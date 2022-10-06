import React, { useContext, useRef } from 'react';
import type { FC } from 'react';
// @ts-ignore
import { useAliveController } from 'react-activation';
import PanelTab from './PanelTab';
import { CaretLeftOutlined, CaretRightOutlined } from '@ant-design/icons';
import { Space } from 'antd';
import { RouteContext } from '@ant-design/pro-layout';

const PanelTabs: FC = () => {
  const { getCachingNodes } = useAliveController();
    const cachingNodes = getCachingNodes()?.reduce((nodes,item)=>{
    if(nodes&&nodes.some(node=>node?.location?.pathname===item?.location?.pathname&&node?.location?.search===item?.location?.search)){
      return [...nodes]
    }
      return [...nodes,item]
  },[]);
  const routeContext = useContext(RouteContext);
  const scrollContainer = useRef<HTMLDivElement>();
  
  return (
    <div
      style={{
        position: 'fixed',
        zIndex: 9,
        width: '100%',
        height: '38px',
        backgroundColor: '#FFFFFF',
        borderTop: '1px solid rgb(216, 220, 229)',
        borderBottom: '1px solid rgb(216, 220, 229)',
        boxShadow: '0 1px 3px 0 rgb(0 0 0 / 12%), 0 0 3px 0 rgb(0 0 0 / 4%)',
      }}
    >
      <style>{`
.panelTabsBar {
  width: calc(100% - ${routeContext.siderWidth}px);
  position: fixed;
  height: 38px;
  display: flex;
  overflow-x: scroll;
  padding: 0 50px 5px 5px;
}
.panelTabsBar::-webkit-scrollbar {
  display: none;
}
  `}</style>
      <div className="panelTabsBar" ref={scrollContainer}>
        {cachingNodes.map((node, idx) => (
          <PanelTab key={idx} node={node} />
        ))}
        <Space
          style={{
            backgroundColor: '#FFFFFF',
            position: 'fixed',
            right: 0,
            paddingRight: '5px',
            height: '35px',
            textAlign: 'center',
            lineHeight: '30px',
            fontSize: '18px',
          }}
        >

        {{{ ^useI18n }}}
        <span style={{fontSize:14,color:cachingNodes.length>Number('{{{ tabsLimit }}}')? 'red':'#a6a6a6'}}>{cachingNodes.length}/{'{{{ tabsLimit }}}'}</span>
        {{{ /useI18n }}}
     
          <CaretLeftOutlined
            style={{ display: 'inline-block', cursor: 'pointer' }}
            onClick={() =>
              (scrollContainer.current.scrollLeft = scrollContainer.current.scrollLeft - 100)
            }
          />
          <CaretRightOutlined
            style={{ display: 'inline-block', cursor: 'pointer' }}
            onClick={() =>
              (scrollContainer.current.scrollLeft = scrollContainer.current.scrollLeft + 100)
            }
          />
        </Space>
      </div>
    </div>
  );
};

export default PanelTabs;
