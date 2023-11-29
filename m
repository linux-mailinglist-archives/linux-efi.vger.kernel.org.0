Return-Path: <linux-efi+bounces-97-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B352B7FD95B
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 15:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68C81C20B58
	for <lists+linux-efi@lfdr.de>; Wed, 29 Nov 2023 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECC2315AB;
	Wed, 29 Nov 2023 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTLrTAsF"
X-Original-To: linux-efi@vger.kernel.org
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 06:29:13 PST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34DE1;
	Wed, 29 Nov 2023 06:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701268154; x=1732804154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VjVFIP6qTwHWmNsJJzuj/XzlIobRxE5Ww7JbsPkiwzw=;
  b=XTLrTAsFyzWqE6TR2jsTs7/or5A9XpXpFyF+85ez0JBwgSmEZp3N3LX6
   DjOJWWjytR867fpF+TLq4W+iklbsWYmxIov9vGDORNBOwRdXkw/9ttKum
   BizlkPYy2UgytrPn9hiHYICi4vO7bKtybwWiheFfJOokgHsOANmc0csH/
   wHU4vazTwlNiqrP0iUgbEgppVFMNWMo8/7OyYudDNbdh85TKzvB4dlkKK
   FHUYsLbDRxOhsCCzmdjPyZTMcebkuwDFgtZDrR7co5r0U+pvs6DCE1pkP
   cvWkELT7AYjW0g4305VWjppGDqK1+1QNefPFgcP1wbIeyAu8xuICj7q5F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="69835"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="69835"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="768932991"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="768932991"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 06:28:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 06:28:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 06:28:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 06:28:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 06:28:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao+503cwjCl9NKf6IJgfcx4/9svb+nIVQ3uShvTbIEYTJKtAJkEihWd3Qw7+l+LLcPajgzrpEWIaA19S8NodhFqT18N/nJgBRT9WsmrFUEv7PF4g1dAMrsZ+1ijgJ5+oyt1QAOd7tPhltSQJBxMiYfTT30/fAqFnC6BUbfQrxhFAijohEvjzmK0E2wcA13PIT07txLhKmwMoyBnOox4gUvl9d3HDxcv34x8P114YPeqa4cQRXkX7OxUKnSFR6V8Ujq032EZUa2n/bOu8uo2ELWASl8psbBxuUKdvXMqVL0oLzPA+QV1EGjwfezryf0SyfGf+/vi5Uu8LGFcDl4RWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qa4EenB18VHv8ODTQT9dPKL5VQ1I7GmIWZSAF3NKXvc=;
 b=Ftl0mFq6Jx8VqEXN3CGBcWjMXbH+VfMkhl7uhfC8gYwAxgu/N3UR3hsdoFjfAoZFtAiwFyCIuoGH6A6rL1s/SazVA9qqwGKPU9mifUBmkHa9h2kfuIE45rCFEwpKzIA0p4Q2aXAjV3l9mQJcYO6EygM9GsgibuRF7SGXlkSiK/REOHGs+DAODysFMzTUqNzfmG9yymisU4NcMD5d694/f+Hjta8LsO1uRqOHr/wyv4b3PX9u55mIQWWGWwvun/voy4MfRFyY3oR53X6PitFyV0bfDuKr3/azvKItv41EphdyItG1kpnrbRZloaea9YM4cF02rGt5Ov/ZvNk6LgdsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 14:28:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 14:28:05 +0000
Date: Wed, 29 Nov 2023 06:28:01 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC v4 5/6] firmware/efi: Process CXL Component Events
Message-ID: <65674a71ef4d0_a1b25294e4@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v4-0-47bb901f135e@intel.com>
 <20230601-cxl-cper-v4-5-47bb901f135e@intel.com>
 <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ec6d2af-c860-9b05-7eaf-c82f50f8e66e@amd.com>
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4eb5e3-fa4f-41e5-0e7f-08dbf0e7667f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQsiUqho8AT0iKAabEhYZnfy+gM66+VBKeQpDDVZxtqnKH/msMWJkVtkfSyTh1Kz0RMgN2HTVupWMF/9kPx9y++/5FIsX4hsCNume7kUQcHc2yZrHzxGev1QAOvZgBYl9WYhOEIpww2lhEqOOcfB8fZIytSPoHkntVR0QA9vfpfk2+aRHgTPgSzlUkQLlMV5cCV7Bt3s3V4DlRM31KKtWeqcaomDbSKo/88VJvpjlKYRvvqazXxyuKLuIdtHVEbyvlcITghlwuOt902ow7NPGQn/zrlRWNx/8QnqjofEL+QHqCiEP29YswaRV6/UemcEDZFwe81wq1uCqouv1e2QJAwKbmilLiH/hEwr3WzwxWXHvhylxLIDUg2qcJsWIfRic43KwV1pMl8iCQRE0Ja02lfqyLwAPpanprEjbUuijnnwZ6WrWeJDZ30Us9AQ7anKfDBb1pI5mGn6O5mohqLt3rfgVeI0qRLVwuK18u43DUkMR8NTacQVAgNnmJZWHFR/Q2JJhfACNFISjqGELK94N0IIu6I8bK8u+X/KHAw4P111nTMk/S/GMhp0kAOhfXgA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8936002)(86362001)(8676002)(4326008)(66556008)(44832011)(66476007)(66946007)(110136005)(54906003)(5660300002)(82960400001)(316002)(2906002)(6506007)(6486002)(38100700002)(478600001)(6666004)(26005)(9686003)(6512007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMcwOpFdY5cy/utLHmBQwpB5cWE2Hu/F4b8Nb7+a+HNUJnmB/edha9Cr2Hq+?=
 =?us-ascii?Q?ocgdiofV1F9LhUPDHsjPeBZvhUaaCEIdhBGvMGMBHrqS8MQkL1tn6MfotCtD?=
 =?us-ascii?Q?Hwtq+7FwJPoYc8uebWdqsKODPMGIFWPxWo+7CY/BAh4si4FNbRByahNW9sb5?=
 =?us-ascii?Q?IhJbbJ2rRoSYQSF7EXJxtOj5NBrUi3OolDFTrGg7Cb8u4/oW8HTxnubY1giE?=
 =?us-ascii?Q?wYqHmGJsfJGPlreqgX4hddGSI7Io8ZP4KKb/K6/q9ja/0r8Ctjmg3bPR7guM?=
 =?us-ascii?Q?zw7GgnXpT2kFTwBVdLxeCzQZZ+5srJAKffEV6XaMofdNWINEO5BAWaTasuYJ?=
 =?us-ascii?Q?HcSdVzMHYPSHh29bEjFj3sjy02sqwRh45qPXgj+OfRUunwASDrHDWVApgYBI?=
 =?us-ascii?Q?yyIGbTdiGEcRIETPFpovsamjUbYi/esFP1Tww+NkKGjdY5PKxc+HMISWJ4Wg?=
 =?us-ascii?Q?2pClg1xHD7WeJ5yg1GnmW4bPlS22Q86dt6LFjZ7UJwrdSgwpsMXEvww9jBy2?=
 =?us-ascii?Q?z2Vy+UuWcHrzuxiEHD7kOrduw7EUHO4lld9Fj2k1HZFnkkFUqt2FjRnPK6PW?=
 =?us-ascii?Q?gsScN6stxKq7AHo3SwuGM052iITf3UIBfyPt0nLp8C/Ip7M4NGCDwy5nPo/t?=
 =?us-ascii?Q?PjMNPmC9TAzfywchfPYNB0GTvnPhd9UFXTUYLfBJTdpoFYonslpU/VcloI2c?=
 =?us-ascii?Q?H5nf4hPP4Tp+T2gJogts3/L49YqjfdlgO28nGUIFsNohisTiCtXHO8Ne32SO?=
 =?us-ascii?Q?jWFwEmT2aZYKtpL1SfTvbSyp30RTQbDZFoSQFSbf/wOHNNNhjmxUVQsRTeK7?=
 =?us-ascii?Q?EVb8w/7TUYuAGq5H5IlVMSy3NvljcWXs8+aXmqsYgd5UJYz9Fx/BoaQ8XhC9?=
 =?us-ascii?Q?PV3m2uwDOAX4TlIBxnnDojJVsbPIlPoBb3lpvtOiC/hM0azsNWVi5RRAry1Z?=
 =?us-ascii?Q?hrBVMrM2ePDWHPrNQz6wWLdsT9DBiMyUnPViTHEhYFhiZJbKvARE9UHg5RL9?=
 =?us-ascii?Q?KyHVGwlmJwrSGUOimBLxNW/WBuWpMj3i2+RI3EkqB+4aQBpdPIm7xcTNry/5?=
 =?us-ascii?Q?diuspguCwdSjTSPv8bsAthCi2A8E6QIolasLg/zaGlc/PrW5qJO/cPKNoRiu?=
 =?us-ascii?Q?szVXUzbeGm1Vl5cgrb7aGSvZ30F9xHaakePPjUXVorPi44vz9K2YZFEq03KY?=
 =?us-ascii?Q?x+01ipsW65lANy0meNIBl9CL0Dy7j7uNFRITDIh06jk9VbN+ddkKWhsGYVWW?=
 =?us-ascii?Q?3D33zX2gMhZSw78l3nCd8frE8R5JOsSYv3e2uVgitpdIjhUx4cK2jYOyqT7Y?=
 =?us-ascii?Q?CQ0/AnKFdpUZlzsalke6nz6Ts6V4IC9h2DLveFwf9VSE2jkrLgWlMgOtb0Dn?=
 =?us-ascii?Q?bzJfde6838+c73U0sk3BMtSrHcbA3oDzI0TZSQ8hbaX1Obtxm21erchikE1O?=
 =?us-ascii?Q?t184uAi4Xq28h/ZbbLl2vF+A62g3fSSG/7Yjk/oxiQnGshclhbu1Q1Oej21v?=
 =?us-ascii?Q?iPoOrd4cgzl3JLE8tsnjnwDK8v8tFpi1pjsxehGPVVXx3pV7T0K1RSj+GUDM?=
 =?us-ascii?Q?Q65GoVhPZ0VGkBNOnVKwEsao+i6IheojtLrMKwT6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4eb5e3-fa4f-41e5-0e7f-08dbf0e7667f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 14:28:05.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODX4bF8EbzIsuY9InePWPJ3n3GtVpSMe+E5yVV3a1vMnTztuqMYQcKEPspyqJx9wLvA2/Hbrj12mIS9Wr9ojZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Hi Ira,
> 
> I tested this out. Just one correction below to make it work.
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
> > +} __packed;
> 
> __packed attribute just for cper_cxl_event_rec still fails to properly 
> align structure elements. Looks like, __packed attribute is needed for 
> all structs (cper_cxl_event_devid and cper_cxl_event_sn) inside 
> cper_cxl_event_rec.
> 
> Seems easier to use global pragma instead.. I could test and obtain the 
> output as expected using pragma..

I did not know that was acceptable in the kernel but I see you used it in
cper_cxl.h before...

Ok I'll do that and spin again.

Thanks so much for testing this!  I was out last week and still don't have
a test environment.

Ira

