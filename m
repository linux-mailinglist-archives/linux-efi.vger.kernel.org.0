Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89BD7E2F9F
	for <lists+linux-efi@lfdr.de>; Mon,  6 Nov 2023 23:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjKFWMd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Nov 2023 17:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjKFWMc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Nov 2023 17:12:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840EB183;
        Mon,  6 Nov 2023 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699308749; x=1730844749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KWfVPtaUXxYD6l8Vct2lCBBnMB46OOyZ1AQJGC8Z0Uo=;
  b=iFg155cYu3j4vIlt+LwJBiyC23kyCOzKOSVRE0ZvFBiDB2LE++/QEusU
   xaEuMFMHLXxOBMfbQUWmH7SFya6RxgFZrfnGEgVM/jJYkr0sSpNuD+h6x
   KCbcC7WZ+34X2K3a9YGkeeHpttIx3qKqQh8V22Sorn85Zol9AAhh2tk5D
   4h7rZJ7xlDAjgCPk58JN8qk8vcFzzGl1YVNhMT05mEHdVmLVL0Df5e3Vt
   QlKdkx3aTXDMAOKpy5Py4ok1QAx4B1KqWSVAmvhnsWAnkVes/5JWd4AZN
   ijJtHNoUgQ2Zmh6nqlWpTT5nfjcsDXbHS8ti6k88xwrn8xNod4qlbeGgv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="379772215"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="379772215"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:12:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3762404"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 14:12:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:12:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 14:12:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 14:12:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyXsOcs6GoBs6C+bBqCViWZ4vhiMZetMZ3jge2Ol3EmchwGoV2nlXam+e0fGCOvWNpvx4QfjVDgjUB2ERJtjUhBisw38INmDQe0Ip4iq2xSigRIsm1+q2GVDCo5N0VyXn23sjEp2994FEYfj6u7eYqv/ZiXd95HdhM/aHGcXevmNNWR8xR80XgpRMeQLjkZmoX+xQMz29p87AvcFu9wUsV7of6SnI0YPmNsGSOZmLk+hCeG7iQ/dsjut2Q7WfyBKPF+BWfz89eM0I+pUtCp+GF4fZfn5PUM7ZFfzU3TYYgosdZL7I+BeJLQ3zL2qiDtS+Q3JXjwsdwSyrlM1bmdiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biDuWQQtw/OpEPl4w852AtTyBidAg26osqsyBXZcLA8=;
 b=Ta7N2L56ta2Rqu12D6n8qaaoXpcyodhvJDN71dZsnStY4DlJJNORIxmLGSaheZ7lPeM27XZhxSHSj5rwdFZvBKR5mtuW1z8h9gxNglM5kN0fC0o69LCFFq03XJIxEJzOnTAJLkVCDY1JZYrRNdK9iFUEBBKrKHK2qXAqUxkXZp6a2/+G4WJ8xOf5AoSyDVsLXiyTltKOc5+IRhiQGno+uv2LVgPlqomWAUUStpM2lOdFjQLUJowTMLvBGYDWudS97Ke+i5HlIGDLKNEpdXqrvEu+EVym4nfNXCIuKJQhWuWWwLjr5ikyCMJ6B38IcGQsfA8aryE550wRVBH3dVaQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:12:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:12:24 +0000
Date:   Mon, 6 Nov 2023 14:12:21 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v3 5/6] firmware/efi: Process CXL Component Events
Message-ID: <654964c510b5c_90fed29485@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
 <20230601-cxl-cper-v3-5-0189d61f7956@intel.com>
 <bd888ca8-39e8-0e68-9bb5-566ef91cee24@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd888ca8-39e8-0e68-9bb5-566ef91cee24@amd.com>
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 859aa56c-c218-441c-58d6-08dbdf157422
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXjqNqoyIWXr9SyK5qpxhYcA+unbXUzT9uQlnDY01zGmZ3qmqENOUblHqCnlZMq2GFYZvfTLePEvBg3jD2vxRp+svmBLuTQUcGIHt1s/9a/Vqzpo2JK3sOYHObmhv3FOJGY63lcPG25/RzcEPBne1PaWuThqnKXdytnronxqcqfL+7okqUupU4t3rq2IFBeralK4Qi/JmBgOjY6uAawZuRYg+1LbIUzMCdnUUR9rxXdMLEHr/5V7uiN9BU5ZFN6ZGKQB8tw1c/VBF9tBuk/34MalUubD1x7Pes4uZNRQS5kf6Oql/r2zZSnTZWmMr6HtHMoSm162UKILvZRoZp0+mIgR03Djw0W1KuGn0dtG6G9TstWUoEPYYrnZbrwrIYZZIffJ9P2ycSLIYqexRSpQGP83E0K65IzTOSieJE2kILGwy6v3ySupgAwzAT1eEnggC8TiEqTUNDDbHUhFloZQBQgLdjPTSbgSi8JyCkPNTppeIrtK9cMUonEr+sG6QjpAwk+YagLW6MHenj2srfkblI0gsO5k/LxIt39ZB1wHS1acZiDVAqnt9u++WrOpx9hJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(4744005)(26005)(38100700002)(86362001)(82960400001)(53546011)(5660300002)(6506007)(478600001)(9686003)(44832011)(6512007)(41300700001)(6486002)(6666004)(66556008)(66476007)(66946007)(54906003)(110136005)(316002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IJLIcFQvSPfvhbNPR+BXqvPOyNFJHuQdI4xP+VqnXvcxfrocSteFytG4RAjM?=
 =?us-ascii?Q?wsTLu0v5APEAj0wD59Pw+4Tn2e23/jAyPOwhO8LLKI6nVESlK1UOW2/aPxgf?=
 =?us-ascii?Q?hwLtAojkN5o6NWNakHNWoKAEmrMbkhk7by+Ga/6k4fCUzPkXFnpAe5idqgbk?=
 =?us-ascii?Q?FMLQepmWIjCKk5yNtJzhRNI975iotl+qiPQ3QJU1xocndoO4URSLmhSG8JN3?=
 =?us-ascii?Q?ABWDoYxj+31k3OFSQ/Y98XpEVu0A9BfKGzc/PLNKZ/Fhq/EQKAItv7rqDcHc?=
 =?us-ascii?Q?UjfCnLCHFy2nqIXrYVlesncnbs+hHQZYG5aPzJ9YVckutINrw7GUL3ICA1S6?=
 =?us-ascii?Q?+Y5GvOHk9ZlBAuq4wQeU3dQT0Qq6shCcXRZ+ByQpTJlKF1InJsns/GjS+yWl?=
 =?us-ascii?Q?6AjjftcFWI/zEio6HHpEjSGmgH9Q4r8gXfyHaaCYh405FnRDQ0y+g7hckv9g?=
 =?us-ascii?Q?VgJ8Cn3Ta5NO6vaB/NT8PzhI1X/fxHSyYVF0gUtX8K4CDDQv622h43k5YDyM?=
 =?us-ascii?Q?FO5Ry5nPeK3taSmkyjoUpNwLcJe4r6YJQTLaMY4xfffcxPMEuBHshkPnd67n?=
 =?us-ascii?Q?40/18cC4/IxrCFSCr+TtYHuZkCtk4WXSD12O4sHAaDAbyE+eVoWHryNKy+10?=
 =?us-ascii?Q?mj23fcUQjhBpyPnL3+kIHagZ18JriFaYBszRS/zhHhqgUCxm3fkVoH5f7eDv?=
 =?us-ascii?Q?z9lwBLxjeRd3V5FoYYKDkWwCsbXu1+xLNY1jGcACvMAj0fbTUVLRUDLZY3Ur?=
 =?us-ascii?Q?4T+KnV0TANaUpX+liEtBs3KK8T9UpBF6W4wR0DjYMv3Nr2pLaUo9mwt2wZSw?=
 =?us-ascii?Q?ZG6YbTDUr2bMwlGfrARDnQEHtJF7qdhzshetGNGiF+NbmQwGZa8QZ4Lvup9B?=
 =?us-ascii?Q?+X85krdtrxw2rkdPml6+8/XkmR7FmRNDf8HX91FBWNvarBaJRtxZZqn1qle5?=
 =?us-ascii?Q?rjZUFhqbwb7AbOhTBoebA/6bKYSnupcNIgLUzCJuHZ/wrtxSbU9uGZsieL7p?=
 =?us-ascii?Q?8Pq7YwvRptryc52p65PjcVUL0kX6Sgimw7BCtGW+CVOxUmKjoBosMEsRO0n5?=
 =?us-ascii?Q?y6pFbF+vk906LYwVe2KdQuGGLxVeipx3aK9gSNlkbEKCd7+TAOTaGlF56AON?=
 =?us-ascii?Q?hQLvsaE8Sn3pkHANkxW0VV5abxzgSmd7ap5EFmk85YQ9xaCb03E9Gf2dH7p7?=
 =?us-ascii?Q?4UFYKCGkXEiOFMtU+yB40yHDqC+Y6k+YPr3r+YamHgV9WhvgNwrr1frvy+1g?=
 =?us-ascii?Q?BZLk5R65asqWB38nq41OL8V6vumXicqD7ckRFtXqnCW2wC2tkDhSGaJHCky+?=
 =?us-ascii?Q?Xm6aOPlj0wDAQ4DmM9JX/YH7OFbugm0ir/keC+52M9RCzvISift5bQO4DbaJ?=
 =?us-ascii?Q?0oqoiEELenUbRDfKwmEW9lBy/XqeUMWdemb3ZiLnQZty+dluT2HV4zD3p8QO?=
 =?us-ascii?Q?buKN7Ybu8rRihleTPRZKUwZ/ud6nVM9cg+Tam/1dqpUNKLD1BK40/bwH6ui0?=
 =?us-ascii?Q?dE3GTHnoOqU7PuH1Gt/4rPIEKabM/NXyg1JCIrCyA7ZScO2sFA06yo2M0NCj?=
 =?us-ascii?Q?M4OCnYZFFqQlcCKftFbXjS/R+zmSHq8fL4kt/XTi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 859aa56c-c218-441c-58d6-08dbdf157422
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:12:24.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA9YY8DrQSBF1ycPHooGLfDgGvg2AIvZMu5IWNcGSCOtRJL7zOa+yg6TKRPAhqO20KRZ7iGZQoHKrhbx3N+izw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita Koralahalli wrote:
> On 11/1/2023 2:11 PM, Ira Weiny wrote:
> 
>

[snip]

> > +
> > +#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
> > +#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
> > +#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
> > +struct cper_cxl_event_rec {
> > +	struct {
> > +		u32 length;
> > +		u64 validation_bits;
> > +		struct cper_cxl_event_devid {
> > +			u16 vendor_id;
> > +			u16 device_id;
> > +			u8 func_num;
> > +			u8 device_num;
> > +			u8 bus_num;
> > +			u16 segment_num;
> > +			u16 slot_num; /* bits 2:0 reserved */
> > +			u8 reserved;
> > +		} device_id;
> > +		struct cper_cxl_event_sn {
> > +			u32 lower_dw;
> > +			u32 upper_dw;
> > +		} dev_serial_num;
> > +	} hdr;
> > +
> > +	union cxl_event event;
> > +};
> 
> Do we need pragma pack or similar for alignment here?

Yes good catch.

Fixed,
Ira
