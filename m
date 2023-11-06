Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B697E2F9A
	for <lists+linux-efi@lfdr.de>; Mon,  6 Nov 2023 23:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjKFWKZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Nov 2023 17:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjKFWKW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Nov 2023 17:10:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484E10D7;
        Mon,  6 Nov 2023 14:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699308618; x=1730844618;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=poYSE1w2EvshmSdOBLpJkfqi7G3kTHgCk+f9D+m51w0=;
  b=TuW4DRm2WW71GuMBAudZFWwfskL98O/HvxhvK41LbsyIKoJwU92vNEqK
   e7MBereoziUVilwrYpwltvXpaiBZN94TJW26UPLJeKKEDeumgpTJDrHS4
   fMCQ+DItIVGkXdr2V7aTEo09tKwWTMD+rZ4aq49QqQp0K4rTuLpxZiRc8
   TZIRJvNBbrZ95lXVu6gsaWPMTRc6nnI6MPRr92xzFp1beC0Z2KqDonHCj
   XctpWhz531deQfgKi0qMsT9Ca9f6bC0yiPYoQpZ3+KxOmaLoMSK1t7S+t
   faC1Fya4XzorUZFTg4zfB8NncFufTyx/NxumFRGXd5aKMt8QuMGli8cR6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475616783"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475616783"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712338179"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="712338179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 14:10:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:10:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 14:10:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 14:10:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIYQu9x9YtIvikxAba0sphsIqew4zwgmodW60K5iUVCbO7E1S+ErPY7+vJ4m2sND8JBVEEjksI+4TXFUx9nmgAqKePsyId+J8f4WrGZA/YBs0sk9R+dhGdRKuw5+FSYWLIeyy01XwVuCEU4ax6Xs1Hd0lLsPKuRGthN4ChkC+IZQEmZyyoGYa2IgI0K2S6HZ+VEIbCEJP5iTZ7E3756aFMUbhry6ikz3mUkYFSd9t1UH97QI7/iz+qhLqlX5qLKACLkn/EgzbtnjbrSRfaBJ0VkjD1bF3oi9RKFuaE1MknnmrtB7tcaKOS8zGiCEbCf4MkA+DWDiPTMwIdLNP7lGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24/s1nwHYP1q3NRitfq/YIZSS+LDxOWyYvOOBZJZLCg=;
 b=VOnCDml0pK4o79A53IhHyj9yjHcLrwcX/M3XSOZLXbomRhZUtJ6yQ0XNTA1NLuXb0n4F/G15exnSdLNfitl4jLG8BQ8h7ffgFwDSfye8p5yXCe9FjXe6rLxwfX/BDpd8XUpgw8mjS5++EZtuiX1dWrtj2cxweStwX20fVW3KqHFsJ2BNON0zMl2ogBLz93yPYPjEuVpWpuD1yLEFWN0SViboax7+hEQlnId92Ms3Pq85DOyx44wvxzYt+guXUkKQD8pxXkbyYVXOHm8BcoxGipkwi7jzphvU5g7hzAq300trSDVuPaaRxPe9PiWtr3Mf53nWXi6RShv8Wm6BZJ+nUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:10:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:10:09 +0000
Date:   Mon, 6 Nov 2023 14:10:06 -0800
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
Subject: Re: [PATCH RFC v3 6/6] cxl/memdev: Register for and process CPER
 events
Message-ID: <6549643e8d8a1_90fed2941f@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v3-0-0189d61f7956@intel.com>
 <20230601-cxl-cper-v3-6-0189d61f7956@intel.com>
 <d286ae7d-ea83-af3e-7df1-8ad83fdbdc57@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d286ae7d-ea83-af3e-7df1-8ad83fdbdc57@amd.com>
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7d1249-a9f5-48fc-3031-08dbdf1523e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbF/339LliFktU8yihRhdyR2xSE+ymz+Hy3Q4SersxcCD5D1PWUz+5/H4Pj0ygwwDPD2Tuft0pvdlTUGkWpGzEYvXaozklv2wf7uZp7cBzPju3obXyAaOWmDLVVFwY2lzkxrzg37Yq4gEoCTCqGCx9D2QSCqwc0wgaoOnGsV3IdJDG7b9MOIFeLJPe9DkK5YzTuoIWA3whELOZuLXF/LHWrpLj+u+GOqHOxpnVVJcR4YXCz82LPY8Lw6VfB43qrBNVUqTqaY4XvaMfBlrSJOUMj2YG2M1MWB447v694wCQAcn2VVOsPBD1WQM4kNHI7ufBPwKXnnYpv4UUUTwfElac9tunXFt4+yvfxO0Be9orLWcsgk8Lx76kPBp88xFX5aen3IWpbUr5ac+wU7TDufQLvApqUthWdIuJa0h2a3m9IhJ4ovrOXZNzzbxYny06w/MmZLOgjKgjy+3FdSmizW7FWceGg6Itg5xX4TUGs9WPhv2A4lWjHHEY7mmYhh3QkY010QFeGphdszukewLtWTphCgEQo4FXMgB3jjn5gr4zojWDb50hoKa3kSfy7WfTFX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(26005)(83380400001)(38100700002)(86362001)(82960400001)(53546011)(5660300002)(6506007)(478600001)(9686003)(44832011)(6512007)(41300700001)(6486002)(6666004)(66556008)(66476007)(66946007)(54906003)(110136005)(316002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4z0YmkwKM4fmtIxEMv6P8qh1ogGC/LFWKecW7N8F8pUa3zoCXf1O/5YAi0Gg?=
 =?us-ascii?Q?QShXvSyOJSphwzSAQwGJCUzd+u6iH5XH0RWLw0W+d4vduKbg6OygYdxvD5kf?=
 =?us-ascii?Q?CBAU0ACum45emGSBT8NIXf/N3ykc27B4sALa51gVE/vrJ3vLbTqnLrIt3q6B?=
 =?us-ascii?Q?BgVGMpwAqSpM6C0bsSwegboB6SrYGij1uZWLSk17qLk4AR3Q+Ag5KPL6FfB5?=
 =?us-ascii?Q?Egb4vNtq8yW2N4blmejDxDgDtfrgdFULZIGmunABbNVSRpEyKkzZSO3wGIac?=
 =?us-ascii?Q?gl1g++sOvm/87qCsaRa7EhP7eEMkVwKSXwAWHL/pmuq9CxSnz4h4fGnTVzTS?=
 =?us-ascii?Q?qDCiCcIed9KvIu0XDllf4KUw5P7YT4M/WC4aR4hGsRpreyHJhur+cy6Y2se9?=
 =?us-ascii?Q?LI+e2yt332eO+nC7+whr+pOsoM0liUUacTfwkhx3cPMjoAN4hmC9EZjnM7sX?=
 =?us-ascii?Q?jIkWlvqvcw64C8oTeFWbqSgL96BdF6sImY0cwDaigqn2U5ehUSE9dR+8J6U2?=
 =?us-ascii?Q?f1XM4uWe3eN0qVAmTH1IsZJU2Awdf3mSyPpoc6fRMLZ0Z/jwUb01HsFGo1gu?=
 =?us-ascii?Q?cVMh4xKR8Nn4Cj6UfSj3tgtozWpQPfWQK1oULnEYipUEQdQZq1w3z1VdmEKt?=
 =?us-ascii?Q?OgiAG8gKvMtqzs8IhIhW2D1DLWBaKtKlccMf0S0N6J0v1N260LmMSwsUc/9Q?=
 =?us-ascii?Q?5XHwwaQF/Y4DAhEOYZU2vcp8gLfr3/imOCokLITzOOXfO/oPZBO3hkrzu58K?=
 =?us-ascii?Q?Ku0Cp0H0Cv3a9JMBzZAQ0o3zfIGDIH4yPL/mEg2kpcHinCPj0IfTgTLiSxg0?=
 =?us-ascii?Q?PnwqDexNtEM7MDK246P2TdqUlEHN6qGGsj7bmwZUYi1I7yE6JHMs1pIb0RUq?=
 =?us-ascii?Q?wGP6KME6xPp/bf/K1OX93bLvfRa3cMFggdxMhTBtNosz2hwokdmKC3iBNF9m?=
 =?us-ascii?Q?Z5SeQHym/fCMggFcaetX2NBNxNReQ6/2KVSma3FYhlBPttIYUdX/hb6V/Wlw?=
 =?us-ascii?Q?B39bW67oPbKSWCmQDUWFpigMeTWBZh15Uh751ck8mPfSglmgcpD91g2tP4XB?=
 =?us-ascii?Q?1/z4J9A7BpjEuxDuy7qfxXZrm0+HzNPzxrJZnmGWot89dsR2fk3Pd/MUuTVS?=
 =?us-ascii?Q?6KTfzgOdAU67DMPNyPjSjruQ0d0OdiIDoWzFGdChBw6P88WYeuVLDbzKVM0C?=
 =?us-ascii?Q?jAvJLmMIcqbeRTzt4eh9keWeKAVBGsX+8UqlkhwywepagHxupPxzxsOqA/9T?=
 =?us-ascii?Q?krZDaeu6kFKTranWAIIHYeHXyg3rbpBo7/PuwLOSRVlHlNWDYT5FIHybt8M2?=
 =?us-ascii?Q?6XAb1oqtuGLZfiouUFTAY3Mq+KaPX4fyagC/jNRVfYbBDeti5QinChEnAWH4?=
 =?us-ascii?Q?GvMdFGMKbQjIfNafcc/ekogXf5jC/VnU5n+8IT9PJ42V+R+2ViZtFzyIsQ7J?=
 =?us-ascii?Q?NFLSUYuwMXbSsSb+6lKF6DZoJgH+oLZyWJ4zyreyXtl3b5cmfl1EjeY1WL+e?=
 =?us-ascii?Q?vpFzDOhUaRhtebuaXMJ/+df8gs0zqG53BoDU8QNZpapUNyjVRrrgaQYTnLKE?=
 =?us-ascii?Q?COwn/nGDVGWRa31xyYo5P1ae4GMZD+m0M8DLyRBj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d1249-a9f5-48fc-3031-08dbdf1523e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:10:09.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug6V4ovQtmMDDCer3QBqhz6YRioNUybNUsrjZw/U0dj+VswBRKTcUlMHkp3MXxbHb7lZJx1nhAeaDJJgQcO+Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Smita Koralahalli wrote:
> On 11/1/2023 2:11 PM, Ira Weiny wrote:
> 

[snip]

> > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > +static int cxl_cper_event_call(struct notifier_block *nb, unsigned long action,
> > +			       void *data)
> > +{
> > +	struct cxl_cper_notifier_data *nd = data;
> > +	struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
> > +	enum cxl_event_log_type log_type;
> > +	struct cxl_memdev_state *mds;
> > +	struct cxl_dev_state *cxlds;
> > +	struct pci_dev *pdev;
> > +	unsigned int devfn;
> > +	u32 hdr_flags;
> > +
> > +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> > +
> > +	/* PCI_DEVFN() would require 2 extra bit shifts; skip those */
> > +	devfn = (device_id->slot_num & 0xfff8) | (device_id->func_num & 0x07);
> 
> devfn = PCI_DEVFN(device_id->device_num, device_id->func_num) should 
> also work correct?

Device num is the slot number right shifted?  If so then yes.  I'm not an
expert on the PCIe nomenclature.

> 
> > +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > +					   device_id->bus_num, devfn);
> > +	cxlds = pci_get_drvdata(pdev);
> > +	if (cxlds != &mds->cxlds) {
> 
> Do we need a error message here?

No, it is just that this event is not for this device.  Another device
will process it.  Or if there is no driver loaded for the device it will
be ignored.  (Same as would happen if the events were coming through the
log because the driver is not monitoring the log.)

Ira
