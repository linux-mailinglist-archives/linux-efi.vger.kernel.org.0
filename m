Return-Path: <linux-efi+bounces-218-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73781351D
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B5A1F21790
	for <lists+linux-efi@lfdr.de>; Thu, 14 Dec 2023 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25F5D90C;
	Thu, 14 Dec 2023 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQTZAOvp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F6B2;
	Thu, 14 Dec 2023 07:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702568740; x=1734104740;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hwmv8afl2cShPBlo+JtVg2D3LpNRtLEMhkLxJ210Fsw=;
  b=iQTZAOvp4pfEqDITEUfYZCEgSoG4lNXimJrXIBisE7lddkVone2PIh3U
   xOlmXN18AsN6kvSMJWoKh/NxImhYZaMoJ0H63lTA4opyIYJXE3tEVh54L
   FaCOcYFwstel+Tn3WR1flbbY2VEaXpzcF2aAMqpnoVJOflMioJ20qn+n/
   gkUoJQ5UwqPzvHihlV/0GoVS4X0xliiqudDrCa9RKGj3+5XiPuoJncKot
   SaXcq/OnleIgKlGUTKTu+d0jgbvvNqYwiiv5GrrmMtRlsKYXfBFd6+sKB
   vx0xQ3fudbcEQB/0K5l7HXJ3kDtQ6vcIdlULYNhpKLY2qIOnQN25VsIVk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380121949"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="380121949"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:45:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="865044726"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="865044726"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 07:45:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 07:45:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 07:45:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 07:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6TGKDWyidHoTbXJFwzd9ux5a244Z4PJiPmC4xyBQ3TBAUJQnZgs9DVNaM72meR4Wo9Q2L15V2hPqg2VbZYJ12bY7GAMA2TUsQa0+qnEcHuuxjkToNfmvj9OApHjDJxjQqutCxE8y95eyCo53dguMv+c+a3g9LSsbDKP3yyl98JsOL00suDkErINWE5yylIRKKf2aCBhsMijHAG8bnxexEtPetrSQYLDBcadVaWo2WSVcJ9qu/Eh0oQmKY2UcQcRecRIJ1YgdjVEsSHFCqkkOVvgXKZS1hUAvc33sbEK/U2bz8ryU2PaDe+4BBwH2CehiuKY4QPdw93b4ZsujxA+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwmv8afl2cShPBlo+JtVg2D3LpNRtLEMhkLxJ210Fsw=;
 b=CagYu0dXO7gsmm5wFdy565NXWgelnVV7Iv23RgB3dhK44cz4yX0HViPO2O6DLTXfLLNUwLYl7x/gHrJANZQuFCxvWNacS7Mar3YDVZ5VnGw7Po1BNAFEvN0jtzJ9tjuWdIk+tLQ/okAn3NXq76VuQQaCvuzsNudpqPuaxONuLF/Lvd2urcNGWz3Mn4gl5mdwXsZP+xkY51F3ph+s8VyR9An/yRei+nynlY5t26RPsolo5uRu/MDj4i2Su6qmmEfFoj1lE6wq2diZJ9w+Pzqay/1FgbYg2ovGKZgL6uefElqDFB54fpLERHEyruD5fTp4V1uouEwyRhVH0vGJlsrWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5993.namprd11.prod.outlook.com (2603:10b6:8:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 15:45:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:45:22 +0000
Date: Thu, 14 Dec 2023 07:45:18 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/7] efi/cxl-cper: Report CPER CXL component events
 through trace events
Message-ID: <657b230e8c070_27323529445@iweiny-mobl.notmuch>
References: <20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231213-cxl-cper-v3-0-7fd863dd0d25@intel.com>
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 645655cf-eb4f-4b4c-0e80-08dbfcbbae68
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOF8q8XqM4De2f/+Wgg3fa13wRntFrhRoVWzuqAllRt4guzN/Zt80q2MrhXPiS4+ZcInc9lOoD6GlVtO2o2itsTGBazGbykbW63qO2Y+vshiP2ULQJDkZZbqXFSz/VQJGtkTjJ/Za/JFxgLuULdayeF9z+85CyBJXh5Lm5kTLvrs71h0RqOZaF5xQg3ZKNLBb1zjRphOcuLcW36ATKEKF8tbVRsi3UcG+uJqQD0gAB0bp0F5f1zz/7Ox54HOtzaqXlFp0sqVokeHXf89uODMyzk3e9PE/TuTgYT3PI/c46cJb5k9r9nz3kBhOBA+H3MSY6ViC2YhOTe0/ay4EPYLB6vddSCHdMjRX2FRvS8q6t7lq80ofYjcpdzTjDYX/1il2082rV5IUbLVYq88JS6Q9vPjYE4nFhc7sMlNCG1d8MOavKfXlBjsTskT76aO4NpoIFnhVyJpyECfS1R2qG4Lfx4flhRAxAbTGITNfb1H03JLbecYlhfvHMDDNyJtSUC9vyN9cXKBqhsXi5lMGymqtRjYa0+clMv8vhhXOw1XcmXKJDG7vJoQGNBfzzk2R9Zo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(6486002)(6512007)(8936002)(6666004)(4326008)(8676002)(83380400001)(478600001)(44832011)(26005)(110136005)(54906003)(66556008)(66476007)(66946007)(316002)(6506007)(5660300002)(7416002)(2906002)(82960400001)(41300700001)(86362001)(38100700002)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsO6dRFLznCTnuF0cT+Fc8EIUIzWWfbjq70Rr2ruo4z8c1b1guzu6wUUvJED?=
 =?us-ascii?Q?edRwnzVIBC5RYJOeCz07k2le+q4wkssNHd9LpPH7se3s/4Z4dI7IpSa0FFOi?=
 =?us-ascii?Q?p1Tgmvq4QWsuGPsn2w2T7TQx7wAIVoD2O89K9dVSGWnqh11f4OEU1X6rps0M?=
 =?us-ascii?Q?6QUxXliGAFXipWCaSpXFR9M4id0WK17h1dTj0LRbCrcSB1N1GF+Q5r873/Lf?=
 =?us-ascii?Q?r3pPiK4YF/XewRTmAtZfXs1LDGFeuI5eCStvlSenMzR7ryU1EjHX3PQRXqN8?=
 =?us-ascii?Q?HOzIoN94L6qR447hucaiaxrdUZSlZkraKw4um9itlO4pdXCW8NfxN0RPf4H5?=
 =?us-ascii?Q?gHjKHX42ddQosBbOYHXK9IwmGBuZnvT/loHxqWWHDUHgXSxg8bDj3937qm8S?=
 =?us-ascii?Q?n/y4wo5vxO3PPTlj6s20FMytOhKVF2Wct9dmHa7PJ+LxcYAAkNEYW+CaGs5r?=
 =?us-ascii?Q?P4YQM+VpwVl+h0mbRx5uZ5djznIVRVCV8xhpBexVb+/bFSZCAuMN1iafLCDN?=
 =?us-ascii?Q?ypGTIb1/xM7fcRgFvA4+nno+dvBMDAocqrwB8PwF+ecQeUJ2pqyaqEd40UNQ?=
 =?us-ascii?Q?RFiRT5n/wzyTkMo367iPBDdE/pSl66swpqxXfTmsaCN9Uw76q/l1Na6n1YZb?=
 =?us-ascii?Q?1x/9oXthPNcHMiQhc1FSIlKXxY5UgDezzJDWNTCyhDTuC/0GeZbvySLpUXSz?=
 =?us-ascii?Q?g2rd+KOdzavPzXdoTeKlBT7ukiXmmscllTR9voS3ES5oPvoLOhrdy3FmTSHF?=
 =?us-ascii?Q?BQ0EjMaL1HUZXPXLQDBE4EOgSgnfxfU1oyLfPxD8kWiwDqOnXMSrnFu8fZPZ?=
 =?us-ascii?Q?JtXnCwg0S/2b/4BwakFiaBVgw929zHo61bado0cS6XfTpXK/ImG21ts7B8QG?=
 =?us-ascii?Q?nRTtvSAss1sgmSmu9QjsKpDp4X1sL4+4jR55HJTkvKM6Kbq4u8ZdluFE1MlU?=
 =?us-ascii?Q?1fbdD9xe+K9qBU2j4ZLxavC6V0ulaSXKCdz2WogAcP0NPLcx/KuBbGmSXezY?=
 =?us-ascii?Q?XTuZJp50M9ndim263hXvDZgyOXCIF1gwztpuzf6ioDau1vU55L2rhlqZ0I7a?=
 =?us-ascii?Q?RsR7xu9dSVEZ40hqSGFuhxQDNi1JKJlwOeYBeXFDt6vDHBMHrG7O8TjjS8KE?=
 =?us-ascii?Q?NxHX58Q7NsihmauxeBn0P8DRizOVyDhb6C4ULG21K0EjckESUx8na72QIZiz?=
 =?us-ascii?Q?Yb3Urjn+mUwW9B+zxWvxMIxgQUBdK9/E+Q1VPLH8PTz056QDYgroPq6KW93j?=
 =?us-ascii?Q?7+bLkXmMBuMZrSPpp/lVXB5hAyVhen2FOs1q3BGFtqVtK+p4xCDSDRUyEWh+?=
 =?us-ascii?Q?7O9PyClyHI66DRDE8BxNVD5V3lto3eTbOdNVWM2dDhzOXi24Fck8Qd0UPDx9?=
 =?us-ascii?Q?qk7sVqyU9fg/JnckU+LqSedycXV8HfASKKxm07k7+V26ibFSxxL/hrYbBAu6?=
 =?us-ascii?Q?djlgBWhhqplqPcEl1DrUARs503bYOxOIcBLPGx37jf1Nz1cm031MZCZwiAyX?=
 =?us-ascii?Q?UbGfQE+iVQb1nfHiCMkemj0JhondR9dBEpyBz9m6mtJoX+hkWOcHkRqJLFc3?=
 =?us-ascii?Q?fcdwZjaddSCOtMLS7d4ZAYIkWyZiQSXEkfCS7nyx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 645655cf-eb4f-4b4c-0e80-08dbfcbbae68
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:45:22.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyBaNjDtNZ3g7h26ekxNn5G0N5/7kr2PTCR9e3bbSOp6jeOPQEb7EDyZdV7cMoF5Pd96OD3nwHgP3De8JCH8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5993
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Series status/background
> ========================

I'll need to send a V4 on this because 0day caught that the changes I made
to the notifier functions were not updated for CONFIG_UEFI_CPER=n case.

Apologies,
Ira

