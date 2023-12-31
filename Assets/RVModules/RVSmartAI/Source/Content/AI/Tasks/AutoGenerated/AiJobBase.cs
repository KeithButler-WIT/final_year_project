// Created by Ronis Vision. All rights reserved
// 13.10.2020.

using System;
using System.Collections.Generic;
using RVModules.RVLoadBalancer;
using RVModules.RVLoadBalancer.Tasks;
using RVModules.RVSmartAI.Content.AI.Contexts;
using RVModules.RVSmartAI.Content.Scanners;
using RVModules.RVSmartAI.GraphElements;
using UnityEngine;
using Object = UnityEngine.Object;

namespace RVModules.RVSmartAI.Content.AI.Tasks.AutoGenerated
{
    public abstract class AiJobBase : AiTask, ILoadBalancedTask
    {
        #region Fields

// AiAgentBaseTask
        private INearbyObjectsProvider nearbyObjectsProvider;
        private IMoveTargetProvider moveTargetProvider;
        protected IWaypointsProvider waypointsProvider;
        protected IMovement movement;
        protected IMovementScanner movementScanner;

        protected IEnvironmentScanner environmentScanner;

// LoadBalancedTask
        [SerializeField]
        protected string name;

        private Action onTaskStart;
        private Action onTaskFinish;

        [SerializeField]
        protected string layer;

        [SerializeField]
        protected int priority;

        protected Action<float> action;

        [SerializeField]
        private bool taskRunning;

        private LoadBalancerConfig loadBalancerConfig;

        #endregion

        #region Properties

// AiAgentBaseTask
        protected Transform MoveTarget
        {
            get => moveTargetProvider.FollowTarget;
            set => moveTargetProvider.FollowTarget = value;
        }

        protected List<Object> NearbyObjects => nearbyObjectsProvider.NearbyObjects;

// LoadBalancedTask
        public bool IsRunning => taskRunning;
        public Action<float> Action => action;
        public string Name => name;
        public int Priority => priority;

        public Action OnTaskStart
        {
            get => onTaskStart;
            set => onTaskStart = value;
        }

        public Action OnTaskFinish
        {
            get => onTaskFinish;
            set => onTaskFinish = value;
        }

        public Action<ILoadBalancedTask> OnTaskFinishInternal { get; set; }

        public string Layer
        {
            get => layer;
            set => layer = value;
        }

        public LoadBalancerConfig BalancerConfig => loadBalancerConfig;

        #endregion

        #region Methods

// AiAgentBaseTask
        protected override void OnContextUpdated()
        {
            movement = (Context as IMovementProvider)?.Movement;
            movementScanner = (Context as IMovementScannerProvider)?.MovementScanner;
            environmentScanner = (Context as IEnvironmentScannerProvider)?.EnvironmentScanner;
            moveTargetProvider = Context as IMoveTargetProvider;
            nearbyObjectsProvider = Context as INearbyObjectsProvider;
            waypointsProvider = Context as IWaypointsProvider;
        }

// LoadBalancedTask
        public void LoadBalancedTask(Action<float> _action, Action _onTaskStart = null, Action _onTaskFinish = null, int _priority = 0, string _name = "")
        {
            action = _action;
            OnTaskStart = _onTaskStart;
            OnTaskFinish = _onTaskFinish;
            priority = _priority;
            SetName(_name);
        }

        public void StartTask() => StartTaskInternal(new LoadBalancerConfig(LoadBalancerType.FixedNumberPerFrame, 1));
        public void StartTask(int frequency) => StartTaskInternal(new LoadBalancerConfig(LoadBalancerType.XtimesPerSecond, frequency));
        public void StartTask(LoadBalancerConfig balancerConfig) => StartTaskInternal(balancerConfig);

        private void StartTaskInternal(LoadBalancerConfig balancerConfig)
        {
            if (taskRunning) return;
            UpdateLoadBalancerConfig(balancerConfig);
            taskRunning = true;
            OnTaskStart?.Invoke();
        }

        public void UpdateLoadBalancerConfig(LoadBalancerConfig _balancerConfig)
        {
            loadBalancerConfig = _balancerConfig;
            LoadBalancerSingleton.Instance.Register(this, action, _balancerConfig);
        }

        public void FinishTask()
        {
            if (!taskRunning) return;
            LB.Unregister(this);
            taskRunning = false;
            OnTaskFinish?.Invoke();
            OnTaskFinishInternal?.Invoke(this);
        }

        protected void SetName(string _name)
        {
            if (!string.IsNullOrEmpty(name)) return;
            name = string.IsNullOrEmpty(_name) ? Action?.ToString() : _name;
        }

        #endregion
    }
}