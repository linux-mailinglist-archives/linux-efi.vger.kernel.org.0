Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421D7CD26B
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjJRCnn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 22:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRCnm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 22:43:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB13AB;
        Tue, 17 Oct 2023 19:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697597020; x=1729133020;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DJh6ggMtOB6Obf+OF1sPL/wUmRU6bjxd3xzGI8b3X1g=;
  b=BoE6rCzL1lO98mTKk6nSt6TYiD0Cbx+pbGeV1dilQyTiDc4OE4KDoglw
   wtAbDnWcnWJIyI/8M1oOURClZ4RFc7J74H2gNjnsCbcMTFclhfP9LMvuj
   8VJeqnzaY5/NsVb1VZxc54qChmYTlmxuCACs0oc4U/s8OZCrmZCykLg0X
   YeVy4DyNEoG26vHHigI141yMOpeopjxBpDohlngRyjazCPHFyrFns1zya
   P+Fg5Q1vODD06nBKxXCpjL1iNXv9Owvp/ncWlyTk19grYelz2htNS0MlQ
   7IQ7dkrLnTi9p3dPUPD/WkqNMP8IInVlwm7UwvT7SLj19bKJaefcQJpwq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370985111"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="370985111"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087728036"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="1087728036"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 19:43:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:43:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 19:43:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 19:43:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka0w0VEEDmGn+pdk1u+RNGeLVA1UAngC0t356xg0RSBl1BKzEQL9n10qKibbNxvX4vaia18FuJX22CqlO4MizBzxx3w2wZf8XYUDvsGFuN+B8LNizA4ux+6RO+o64BA6MxXu6TPJFd5VxHWr9h2/sqSt2q+F3UWQRAWXENLazgLsuTjoTW2JV52COOabiQiuUfLPDImku3xUrRZCHjGA0gqV8Em/rBqwLbTyopmXMcjhTUMDXSggbpFWMz3LSJ/4U0KyRGbTeVCdt4q74neBw6KmWIjg/NMcCsMQOe4cQxK7hPd5zteMmNnJI7yFtCIhY6ENnhh9xJP0TsI2sVJxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTE7+6VibVCicC/5YEQpzZmBw9BxvEW92BBhHLHzSZ8=;
 b=KSw8y1NSt7dqig5blxqyvNGtl4ATOPO36W6SqGdCLOMANVX8zEOBg7H0GU9n72dDmbam/7rq5lfto4TLrPdjLOpSxZKm6f2rVD1shDlBJiB5RPn5AphwShJuY0RWbRTPCB00Tm8LJmNEogHoS/5lNVzY3+MOoY+3DyK7b6u98AceRMwIrrbEcUeMnvm41izq9Wfrw5g/0fgB/rNV6OzlcZqKuVzJDpKiT8297NLn6L9S0xqA65h7ObEk9/jvGMIn74c7i4FIW4DCBaaFHxKiOcKHmbh63mLyZmxFqkQg0tDfOUF5/olVcHTBxmx8WVtjfteaHCHmxPMtlFgKkh0wIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 02:43:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 02:43:34 +0000
Date:   Tue, 17 Oct 2023 19:43:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC 1/2] firmware/efi: Process CXL Component Events
Message-ID: <652f465489b2b_2bb5d829431@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-99ba43f8f770@intel.com>
 <20230601-cxl-cper-v1-1-99ba43f8f770@intel.com>
 <652f4505231c7_2bb07d29483@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <652f4505231c7_2bb07d29483@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: bf781bf1-7273-4736-db0c-08dbcf84060f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ePy3Eh7v08iY+Y6jeCrBFP9UiIX+pWX0U3V/R8I8+XayAVPDjVFGCbXakXeukC4ojV+N4EKBpnY7AN5/FU3hi7XTUyu0vsXkKxJN0dWv1BtxhCoU68yk57ESJZDhEtoLPyZXWr+o9MDB8TxzWaN0ns4w8Ap8M8IMgSGqp51VPC4SOIbn8lki5Jj1SzD0qxM4Goe7vDcRNiCtosavZp4VTupGLjOX7swGuBbgfBF3eB/kaM9x1fM0mc97pb5J56QsbPLoxyH0bmFmvIAjNojxY03iDYE8vNNFjyFpV2YBLzO6FIhEqLh9I+Rljzuii6aKIhdwhEs1EHTO5qCV9vZvCb7YkZbCc9YewU7JCfi74BzHQI3IyUbuTp3wlJeOyWZ6Cdpvex5c8VfyagqBzkXRfIuk3l9K9iZRwZYVu0EkkJwCTS0cK0o/FcZdTlb4G4rrFtSzbEmB3KgymIxXtYH2UOib7JgI7GR+EBaamQfbDuRU6/2JLuWrJBRm3OvBtcmJ3E0fpbudptvnoKanNqgPCPNLGGT1AAP8u7FLKhpzVMD/PInMzmbQFU5RXA4GY44
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(54906003)(316002)(66476007)(110136005)(86362001)(66946007)(66556008)(44832011)(5660300002)(82960400001)(41300700001)(4744005)(2906002)(38100700002)(8936002)(4326008)(8676002)(6512007)(26005)(9686003)(107886003)(6506007)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PpiAdr1kHNumXpvNMxvf6ltoYKZd9LtTXfZuaM6VjWNjqYoR2nlPQCpy/17c?=
 =?us-ascii?Q?Ysttt8sxePG8YXgixeIHZVavuY3cf1NJqb/gkLCOqOyJwohhUm8kGDUEHWi8?=
 =?us-ascii?Q?o9r1tQA4tsjPo7maSg8GiEIqIHgVC37Y+jTzBkLhpUnQCWxUfN4cjFfcfP7R?=
 =?us-ascii?Q?Z+9hPzS14bU3j147N4GOPd0oRJ3yB7kQ2VzK9zrI9/bKrxgvG6Z+QYr7w1zl?=
 =?us-ascii?Q?OTajPJIs0hE2Gg4MSx9tMR1f4xkq56h3MpOqeUVcLCS3L0Fhuqokrkf0zjIF?=
 =?us-ascii?Q?jEZ2jEo0Zr+KtMC+W90VVRg/2801vnNBT3jM1ziWiETv70oDOsbaAUJ/bj84?=
 =?us-ascii?Q?IPJCNuriXJMWL/ox0DbjkbTT0KsGnINxmS1MJAJeYTDrrK2Fwnx8trf9SZKt?=
 =?us-ascii?Q?QoOKOM2R7cIk9mR4BMjelyhZzhmA/NjrKFrm1ui3wl9W4fXEXbdZZ8WgBUd+?=
 =?us-ascii?Q?Rn5HUYQbH37gkboOspimiATtl8WCv7evlBaIz5a3WRzclKpQvMTHDkTfOsCG?=
 =?us-ascii?Q?X6nU0fmxdsNUIyY5H60daf62P7AfGGNA/Y/1kqosRESZI0coRRzi02UBmv5u?=
 =?us-ascii?Q?pltzqFPxof/N734fyWeoqPWBS8qkEjlb2qSXT83yJ9hAeNjnVU2JJ1HX7QYM?=
 =?us-ascii?Q?1dsCEgTvXGWC3ZHKfDogH5wFmMBbZMUhy+N+EL+nZlPy+4UHvniTz/0cJC24?=
 =?us-ascii?Q?POawL/r0fZcaBg2Dv7++65l3567hbO/gx+uPEWDtjpUzFpeTwi/EFSOzgC/C?=
 =?us-ascii?Q?yn8oLOTO8/gtUfP2HLPm+pB9UaAeohAy0Xs/mfzS/JiqKMVG6mYmFUHfTkl8?=
 =?us-ascii?Q?8iWIXChCEQhYmVDTw1v0ZTcWjmicNR/YzZ1yOQpgCwVDxN8mYZXyHRd+HIPv?=
 =?us-ascii?Q?KbtJ96VyKOgvWCG8J0Wldebo87j/Mfjzx/FgeH2ODyu3gsFiJNFbBup2Z/Mw?=
 =?us-ascii?Q?njhbOqWmxjFoZ8SzjWn0GAH2QNQhT1tYaPwU+9i9W5+dgkoL2484c+KrDcc8?=
 =?us-ascii?Q?iQ7rS92eOe3O145RrX90vtL2hkkb25MELpM3LNusAOQ2l0jZOnXE7eK6xEnf?=
 =?us-ascii?Q?km0PJKR0FU6MkYX5f9utp3cGVNBzOIefl8IKd/ae1C6/77ZmjL2kma6twG6o?=
 =?us-ascii?Q?2KJZ67dodebnrLyp7K8hdJzaeE5Rs7aZ/Cd0MJdpTzSlKsc/Cr1QDeJDs68g?=
 =?us-ascii?Q?XaQvg8WjB95GQbMq7whDRHyWhDb3U4/QxwizzYhOt8jBfxVPsPMV98KKrN0o?=
 =?us-ascii?Q?GfLrj51Txcrq51jnmEcU1MBewxmZdlhiKFGikQjqlmI9jMRI+vf6I6xxXbCN?=
 =?us-ascii?Q?g3bddtDV0aIL0JfU3Q2I7ax1SwWazUpGCJ2lIjFt1VsIqIqNQZ4IlsklyzXt?=
 =?us-ascii?Q?wTUT1qAD23w7JDvNOnKpgvyZyW9oyJ7ycbIZ9agm3D4Y4vBv9yGUKFPqg+Bm?=
 =?us-ascii?Q?1ee/GCUSQosHIB5oYjX5HCgHoydCLbz09uuTSIHc2h/ef4+MC3r8xYk1EGJF?=
 =?us-ascii?Q?JUGWpD1XlBmriJ5+34Hqme93j25c9h7w8l7OpG0vn/eoaF/mS8Oy58yAHoVb?=
 =?us-ascii?Q?dMS5yZfrqP7oauIyZQJK93WdxtSwXJw+mbgjO/2q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf781bf1-7273-4736-db0c-08dbcf84060f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 02:43:34.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMpObOHReu7Nxh5f3PJKpDZ87Jk81XHW7d+ajbOpVFkcLAbpitzHI69V9mQDEUndVpVeL/oEO3poenlfiYezyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ira Weiny wrote:
> Ira Weiny wrote:

[snip]

> > 
> > diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> > index 35c37f667781..af2c59f5e21d 100644
> > --- a/drivers/firmware/efi/cper.c
> > +++ b/drivers/firmware/efi/cper.c
> > @@ -607,6 +607,22 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
> >  			cper_print_prot_err(newpfx, prot_err);
> >  		else
> >  			goto err_section_too_small;
> > +	} else if (guid_equal(sec_type, &gen_media_event_guid) ||
> > +		   guid_equal(sec_type, &dram_event_guid) ||
> > +		   guid_equal(sec_type, &mem_mod_event_guid)) {
> > +		struct cper_cxl_event_rec *rec = acpi_hest_get_payload(gdata);
> > +
> 
> Smita,
> 
> Dan and I were discussing the processing of these GUIDs vs the UUIDs in the
> trace prints offline.
> 
> Here we could separate out the comparisons and use a token for the events
> rather than passing the guid through to be converted into a uuid...
> 

Sorry I hit send too soon...  Please see my other post.

Ira

[snip]
