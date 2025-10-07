Return-Path: <linux-efi+bounces-4983-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84274BC25CB
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5181219A48DE
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AA2E88A7;
	Tue,  7 Oct 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btdghVIJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912312206A7;
	Tue,  7 Oct 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861192; cv=fail; b=NnejJBwF08Ac8Yi9Zg8yAp9lEZ2UaKGJLInGZAxmmHAXXRs++MWt2+RJjgp77N4ugdHQaXGOOx1lecVbQJhB3SQIdqNFB80JVxFgiHhUgvWHura+ClIiqu+NYFuePFvGIzeZT9ebyf5Z0Nh7jKutsDMbPh94ZHwYOMTJ3vXiD0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861192; c=relaxed/simple;
	bh=ZLDzZ/gxhNtAhaki1HR8rwWngDDD9nc+KwE/oZ+YJhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQ5ch9rYuiLJQmdo2h5AozfN0hsgDlMlwOcUiSFP2BU/AtT3GDc3FE22PucRnLm6UDnLFdah+w5rRqReKY5ZKOxhy7tEdKE/DDBw6OCfuHdVM+9jC/yUgxNVlh547EJen2gsvuqMejaf3tq7ZymJ5l/U9Rby38yNrW+KTYM2AUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btdghVIJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759861191; x=1791397191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZLDzZ/gxhNtAhaki1HR8rwWngDDD9nc+KwE/oZ+YJhw=;
  b=btdghVIJETsVZwRHQLrYHo+lr29WvSd85FGKktYq2OKRMIcYDdkY5BqL
   FzTk9LKNN2OOX8mCHyqhsAM3zFONKErjKJPDiIIUw5r4U6zbHPo5oFDar
   Eq/UR4p/WCbhErea8OxfCwCL5xtiaBclU0+e39paT8PbwIoG1B+cOiUYw
   0uQhNbFkNQM9Tw2fsKJIPMhJQiuRB7v1IdfFfJcbrsax+TDQaKUhPppo/
   9Je4XQMsRqEe9TrucAYHANhPW8q2xnvBHEo3LvQndRBAEZAps3yAl8vTs
   UJlcQ1HbPBy7MiWcs6XdbPKIazn2PXkCSymBFvtWk9enxFSsF1Xk7+yaL
   A==;
X-CSE-ConnectionGUID: 6qL6jZZ8SluZxm4BRW5a4Q==
X-CSE-MsgGUID: nzqInNLwQjOLMiin3zroxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="73154885"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="73154885"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:19:50 -0700
X-CSE-ConnectionGUID: CUgOVX7pQiyiKj0FeDfiNQ==
X-CSE-MsgGUID: xJwVBNiaSfmwoU2Fsro5qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180264406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:19:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:19:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 11:19:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 11:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo6Pjns2abJKxMVlKxa0VkqbbvLV+ySyPkCOX3XTx5NX82nYv8XmloqneMYsaz0NQAhPbGhX+8x1Gp2pyWuxWF+T9fYleiXa+B/BAK2+3wmnVaVB7R1vwGCAuGmx3c0PL5Hraa1/MPcn/byTiVHfvie2yENbwNr7Z2O0nm4c0OwTaTM6ClA0EfFEHEnfPXvEAUSsPn+dXmUp99IlO/59AntaI2Bf1dRw9yc04vpnxfQ8LMTVq2wCbEjGoRU18aFCIKE/gs0lOgD6ghalkYtK57JFiivSJPdaSL9XnM34Pm2ZvSVPpa4i2PwqEmyBPkgZt2J76n7ehp7eAn1WzNy3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLDzZ/gxhNtAhaki1HR8rwWngDDD9nc+KwE/oZ+YJhw=;
 b=STIyOkVMuDCkmUUY/ihVEZgSELKqhHXkVaHMJsdqDte+/C5RuZC0Km2mxcmw6aiwVP3cFP4OkzR2Gr1jKaepxIrYOwRg7/p8yaiUjKdWrg0vSeSca6NpQTFbiz+e0S6vqr0KWCnu80X3BvUQxVXErhg0VktOUdt5lPeK0fTDs4POHVilBpci8PtuKBjQr8J4CMUBzDeOcpnFTZH0pNGfTEdB6JmGZxjvz8qamvLl/TujBXTXD4i/m9a1b3wvZ96wPHlvomVIu9EXG36GvJxQU1ctZ/n9brW0qP1yHAGr9Nc298HRtmtknVW+GC5HVd+LHbCY4S1KjtKoTYofB/AzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 18:19:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 18:19:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Thread-Topic: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Thread-Index: AQHcN1ctIPgyjz2Uhk2A2Ka753Z4xbS2/zEA
Date: Tue, 7 Oct 2025 18:19:37 +0000
Message-ID: <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-2-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-2-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA3PR11MB7433:EE_
x-ms-office365-filtering-correlation-id: 5d65f033-8aa6-4818-31cd-08de05ce1316
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZVVHTjgzK2d2MUNOckFSdExMNC9yTTNYQUlnenpldVBtMkRncC9JMkNuQ0lI?=
 =?utf-8?B?Q2o1VlNJNWl4MFhvR3k5bjhGZnN3cWo5LzRML2RyQ3cxaDFmaTlwUjYzTk0r?=
 =?utf-8?B?RXhTbFNoNzF5UWRWY1hKZmJyS3M3TU84SkhQb2lZNFJzeFFONVEvTUlxdkhC?=
 =?utf-8?B?M1dkaDBqT3dRT1ZYUE1qcjNZMmI4QkhXaXBUVitsbzZoQkMxb3NlZ2NkUU12?=
 =?utf-8?B?Z2tNR3NId1JSVWZBdlFWMFlpSk5NbzBzaVVYK3VtUzJja0pzUVh6UGhwcnVO?=
 =?utf-8?B?M1RqMlV0Zis2UzMwR0Z3YlBORDdTM0dkV0F6TXFkai92K2M0VFhMbjJQL0hL?=
 =?utf-8?B?UDFsZjlKWGpYcDFHRDRoWDRIcURNZzNybFRQT3pLY1ZsT1JZVC9GUVRqd2t1?=
 =?utf-8?B?WSsvdVllOWlJbzh4SU9NWkYzMkx6SWxJTVZzdk1xQjJwQzh1WmphL2krZkhP?=
 =?utf-8?B?VXJjOEJZZmk2czFPVWhJSHlBT2JEUyt6UkpCZnBORGdwVFVVYzJTc2Q1ckho?=
 =?utf-8?B?UVBONGpYUDQ5S0tmU2FvWXZaSHdpYlJZSVh3RFR2OHZBK202QUxDUENzOFQ3?=
 =?utf-8?B?UlBWUzBoa1lBSmhCK3J2L1pJMzRuaTh1QWJtanltU1lLZDZmdzdWQjlCMFlC?=
 =?utf-8?B?ekRPVURkNWY5TjFQeGtiWUJmVEtFdGdTTitkSWRJaG9sRTBnSDd4ZENaOXZp?=
 =?utf-8?B?WTZNSlRGWXorZ3BDbjB2YUdWWi9VTUdTNUNTU0NsRmpWYVVySHg2U2NidVZi?=
 =?utf-8?B?cU5yUUFZTkMxTmZHcVNNanJ4YVJqaC85T0w2RWY3d09EbTd3cUhJS3R3Vk12?=
 =?utf-8?B?V2ZXNDVtZnRReU0vb0pNUEJHTisvVEQ4bWZKWU1INHdRZ2w1V3piZ2FLYXox?=
 =?utf-8?B?eTJNMVpzWTNZVVJXZnkzcmhhMVBWaWVKNCtEN24vUFhmY3A4SEo1NUIzUjVV?=
 =?utf-8?B?dnB0N2FaS3hqa0hGKzBPMHh5eEw3QmN4cFR0WUpqVEZwSnBxN01DaWlyWlhn?=
 =?utf-8?B?YUFXT1BVOFVLeHVZRSt5cW9VdjFyOGVWRmNqaGRHeHhpZDEyYWZmSVFvTlFw?=
 =?utf-8?B?TVFUbmhuYWx0Tk5sUjZuYW91MjNoMm1sRWM0S2xZa3R2TnUrOWxzcjc3WFRJ?=
 =?utf-8?B?WlF3YzNMVk4xV00rMXZGZ01KNUVnckhQTWRscm0zTmJPS0VBUGR3WjduMkFC?=
 =?utf-8?B?TXRJQUF2d2JiV2pmSDc3d2x0eFZoQStrY0loWHlhVTFvbURBVFBxUEhzQkw3?=
 =?utf-8?B?VGkxY05vZTM0N0tIUXdTUjRXMmVLUnd5T20rV2IwcEJ3RGQwTnVzTEtGTXU2?=
 =?utf-8?B?UUpSZHVHaUlxbzFhQjBqcVVQQ1pqQmkxb01RL0lVOHRFSlhxQTM5amZibXFS?=
 =?utf-8?B?RUlRdW9UQzhGWmJIY3FYR015OCtoL2VVcVJ3dXV5eHVPOUhxWitTaTZWa1Yy?=
 =?utf-8?B?ajFDa2orYTdCaTV2ZnFoSW5wazNRbWg0NWlyVHlsbHJvZHg4cVJiaWlsdXlX?=
 =?utf-8?B?TXd3QWMzNVdLZ2JkdDhGR256T2VvTVFkelFTSFFNaU1VeGVVTmwvYldLY1Vt?=
 =?utf-8?B?RlhBRTNjQWROaXYwbGpMb0ZUU3lBVFFoRVA3aEFlRHFqb0JtME5rSDh0WFAz?=
 =?utf-8?B?by9rNWhzQjgrUnV6Um1UT2ZPak5nUVlTNTA3K1cxODc1L0ptUmlscDJpZG14?=
 =?utf-8?B?TytZMDhRM1VoZE1odUNwM01Cd3Ayd25odllOT0NDbUlqeDl6cDJiWCt5YU9p?=
 =?utf-8?B?cEZTV3pQVEljUjVadDJwekN2OVZxRjVMSW12SmFKWnZLblFaY1QvcDBaNWdo?=
 =?utf-8?B?V0FKekhlQ1VIcEpnc2lRWjBpajI0aTVpbm1YdzBMa3VoMk8xS0ZiWDE5em1E?=
 =?utf-8?B?blVxZzBEZXA3S1lNSFA5dDlHZ2tWeE4xWUYrVUtKeExDWFVWSFdMZmhJYnNp?=
 =?utf-8?Q?ymNs9Cfj+YNLEwsK1wcOtOrZjh2f/ScF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmRuZ0JyY3M5NG51ODJoMk4zbm9UMjlwZHBjRy9HSmIzcmpvT2ltVTR0V0g0?=
 =?utf-8?B?MHQ2cUZtNEs0L25MYlVVcTRId2tpTWIxK2I5ejNwckRvNGJzWDlSU294VHVa?=
 =?utf-8?B?UWdGSEV1SXlrVVY4M0V2TWkvV0ZJazFISTJEa0IzMjExNGdsdm1TbWpyNmtS?=
 =?utf-8?B?TWxDNUQwUlNzSmVmZENCSGV1L3hQWmhQS0xQMWZFd1JEb3pMbnEyRUl6eHZP?=
 =?utf-8?B?eWVXZXc3S09qczEvTkJkQWdjNS82SzhTTExsUFYwWDhCei83Skd1KzRRVkVs?=
 =?utf-8?B?SjBPL042NmlFK0FCSWcwZU5YVWwzUDdocnpDLzJSaGRqTVh6OERmSDQ5WTFW?=
 =?utf-8?B?enBhWlRYUEJyZzNjc1I5V1FnM3p0UzlrVHBiWmIvVm9DOE8rdVZ5aUxZZHBu?=
 =?utf-8?B?RUZoV0VvZ0RZT3o1RzV2dVpqK1Q2c0MrbDZLSDlkS0xDb2pKSFhHcnV3NGlG?=
 =?utf-8?B?N2x3QUZsL0hiN1dWcmQyUElnTmpnNFNBdmhpS1ZwMHRXUlU4YStNWFBqOEwv?=
 =?utf-8?B?QjBLL2VSV1NGVkNHYWdjb3dySDJVQjUxay9pcWwvVS9YK21pWVBHeittYTRa?=
 =?utf-8?B?TUVQd1NkRHoxZmp2Rit3cjlPUUEvWjRsYTY2b29lMXZKS053T3lKcXlKeG1F?=
 =?utf-8?B?SU5ON0VZT1lmY0ZVbEJyUGxMenhtUTBjUGNWek5jcW8wTll3a3lWYUhIQTRz?=
 =?utf-8?B?RVFqaDhjcGxEN29paXAvWGRvWjBuNldxZ2tJbUVQajUwNFE5bHpqTEVnZUZo?=
 =?utf-8?B?ZFhuNDIxajkxdFBPbGUxMlM2Wjl0U3pQaTdRWERXdjJxYlRqQzNUelhCV0Z5?=
 =?utf-8?B?cEYvSVMvVFZacHd5eXVYNkFaL3BMMDNNWWFaNDloTTFzNVJ0UHdJM0NtcjRC?=
 =?utf-8?B?MzJZbkY1NlVXdU4vRDVxeVlOaVR6dDJrRnZ4TlFtVWNhejE1d2pYTGk1QzI0?=
 =?utf-8?B?em1SR1RyUTFQZWU0YWhaR3ZkL3NoTHdMcWE1bVZKdDc1Yll0RHFDVFo0Rlox?=
 =?utf-8?B?TTFiMDE3Y05YcVdjOGUwbktLMVNsczRjbDFieWV0VXZxSjZvNDhiMGEyWHVM?=
 =?utf-8?B?bEhwdDNLbmZvMHo5RG16TGJMSjhtNFEyZUhxS1JTOUV5eWk4T0FGeUdwTkpE?=
 =?utf-8?B?eld1U2I4Q2l4Z1Roak13bERBL3ZFSy8rRW1WSEtFL0tyYldRd3dPRFFpbUhM?=
 =?utf-8?B?TzZpQzdqbk4vZWdCaHE2SXQ2Rk41TDY3cWcwS0xaRmw4amh6Q1pNT1Q4dGZ1?=
 =?utf-8?B?MHpPV1RkNklVWkNldnpqcjgrb2pMR0Zpa0JSZXRualRiVFJFMEtFalFsSk5I?=
 =?utf-8?B?aWFmWmY2Y2UyRkhCSHhjZHZQOUxoS2NBdGtsTUZNa2Roemg4aGhUM1hrejF1?=
 =?utf-8?B?dTNFa2oyV0ZHcmRVbnZEbHQvS1lvWEtlMXE3YUZ0OUZqM1pLYi9mb1lvUkVq?=
 =?utf-8?B?TGQ1MTJ4eDY5cDd3SlhvWTFJUWlBQ3hIa3BvM3ZNQ2JvNlpobTdZdytHeEox?=
 =?utf-8?B?YThsTGNuZjgvWHRFSVNleEhyTGRWV3loM0xoMmZDMWhITm5sZ0V0blBlZU84?=
 =?utf-8?B?UFgycHk4VzJmN3FTM3p6eUdQN3lJRWFnZ0YyNERhZmhTemxqMDhLTmh1MjN3?=
 =?utf-8?B?QlJhWUtWUTg2TG82MytMaGhiRVNULzU1Ky9xNXFPaCtHa3ZmaTk2c1FXV281?=
 =?utf-8?B?d0xvK2MrNEVMWmQ0NTN4R05kZ2d6Q3M2TkdIbGFtYkRXL08rc0pHOHluMzdq?=
 =?utf-8?B?SDMra2gyOUdkOWs4dVk4cHlDTWQxOVZ6Y1VZQVpHVzVudENUUmpjaDJCYjVR?=
 =?utf-8?B?SVBWVmo2NHllaGdBSUxVL1BCN0R6WkpjMk0rckhmR3FYYURpOUZMTEZoZzVG?=
 =?utf-8?B?eFV6cGJWS0dQUXloRGVmUVFsc2VkWFdCZVhHL29mWlNYMnRKUUtIV0VNUTI2?=
 =?utf-8?B?NER2bUNLcnBXeFh0b0hpTHMwTTlyZmkycml2akhib0lyeUJLbGp2cFJxWGgy?=
 =?utf-8?B?YVl0c0NDdFJKenVQdEZNWFE5ZFNtblVIazgzS24rSXdwV3FjMnNYUERJMXJO?=
 =?utf-8?B?Q2lnY096c0ZaMHBRVVErbHV5dVJCMjAzVURFZFhWOHVCQzkwWmYxc1lvK3k2?=
 =?utf-8?B?Mi84SWYycUp3RDBGYndYUEttVFBJblpGSE4wOEtVTWF5NlJIbk15b2x5dVQ3?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B651F83CBCB9745911025BE5FE78DCD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d65f033-8aa6-4818-31cd-08de05ce1316
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 18:19:37.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0EEkhHFI4gcLqphkH9NeSEkSWYbHoUi8mC6brr15cDp0aiyNr8L7ikRJ3u6FS9n1gdD+wabwGWEr3UePlJlNb4IsF3VpABVJU3DuyXNAMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
TGluZWFyIEFkZHJlc3MgU3BhY2UgU2VwYXJhdGlvbiAoTEFTUykgaXMgYSBzZWN1cml0eSBmZWF0
dXJlIHRoYXQNCj4gaW50ZW5kcyB0byBwcmV2ZW50IG1hbGljaW91cyB2aXJ0dWFsIGFkZHJlc3Mg
c3BhY2UgYWNjZXNzZXMgYWNyb3NzDQo+IHVzZXIva2VybmVsIG1vZGUuDQo+IA0KPiBTdWNoIG1v
ZGUgYmFzZWQgYWNjZXNzIHByb3RlY3Rpb24gYWxyZWFkeSBleGlzdHMgdG9kYXkgd2l0aCBwYWdp
bmcgYW5kDQo+IGZlYXR1cmVzIHN1Y2ggYXMgU01FUCBhbmQgU01BUC4gSG93ZXZlciwgdG8gZW5m
b3JjZSB0aGVzZSBwcm90ZWN0aW9ucywNCj4gdGhlIHByb2Nlc3NvciBtdXN0IHRyYXZlcnNlIHRo
ZSBwYWdpbmcgc3RydWN0dXJlcyBpbiBtZW1vcnkuIEFuIGF0dGFja2VyDQo+IGNhbiB1c2UgdGlt
aW5nIGluZm9ybWF0aW9uIHJlc3VsdGluZyBmcm9tIHRoaXMgdHJhdmVyc2FsIHRvIGRldGVybWlu
ZQ0KPiBkZXRhaWxzIGFib3V0IHRoZSBwYWdpbmcgc3RydWN0dXJlcywgYW5kIHRvIGRldGVybWlu
ZSB0aGUgbGF5b3V0IG9mIHRoZQ0KPiBrZXJuZWwgbWVtb3J5Lg0KPiANCj4gTEFTUyBwcm92aWRl
cyB0aGUgc2FtZSBtb2RlLWJhc2VkIHByb3RlY3Rpb25zIGFzIHBhZ2luZyBidXQgd2l0aG91dA0K
PiB0cmF2ZXJzaW5nIHRoZSBwYWdpbmcgc3RydWN0dXJlcy4gQmVjYXVzZSB0aGUgcHJvdGVjdGlv
bnMgYXJlIGVuZm9yY2VkDQo+IHByZS1wYWdpbmcsIGFuIGF0dGFja2VyIHdpbGwgbm90IGJlIGFi
bGUgdG8gZGVyaXZlIHBhZ2luZy1iYXNlZCB0aW1pbmcNCg0KTml0OiBwcmUtcGFnZSB3YWxrIG1h
eWJlPyBPdGhlcndpc2UgaXQgY291bGQgc291bmQgbGlrZSBiZWZvcmUgcGFnaW5nIGlzIGVuYWJs
ZWQNCmR1cmluZyBib290Lg0KDQo+IGluZm9ybWF0aW9uIGZyb20gdGhlIHZhcmlvdXMgY2FjaGlu
ZyBzdHJ1Y3R1cmVzIHN1Y2ggYXMgdGhlIFRMQnMsDQo+IG1pZC1sZXZlbCBjYWNoZXMsIHBhZ2Ug
d2Fsa2VyLCBkYXRhIGNhY2hlcywgZXRjLg0KPiANCj4gTEFTUyBlbmZvcmNlbWVudCByZWxpZXMg
b24gdGhlIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiB0byBkaXZpZGUgdGhlDQo+IDY0LWJpdCB2aXJ0
dWFsIGFkZHJlc3Mgc3BhY2UgaW50byB0d28gaGFsdmVzOg0KPiAgIEFkZHJbNjNdPTAgLT4gVXNl
ciBhZGRyZXNzIHNwYWNlDQo+ICAgQWRkcls2M109MSAtPiBLZXJuZWwgYWRkcmVzcyBzcGFjZQ0K
PiANCj4gQW55IGRhdGEgYWNjZXNzIG9yIGNvZGUgZXhlY3V0aW9uIGFjcm9zcyBhZGRyZXNzIHNw
YWNlcyB0eXBpY2FsbHkNCj4gcmVzdWx0cyBpbiBhICNHUCBmYXVsdC4gVGhlIExBU1MgZW5mb3Jj
ZW1lbnQgZm9yIGtlcm5lbCBkYXRhIGFjY2Vzc2VzIGlzDQo+IGRlcGVuZGVudCBvbiBDUjQuU01B
UCBiZWluZyBzZXQuIFRoZSBlbmZvcmNlbWVudCBjYW4gYmUgZGlzYWJsZWQgYnkNCj4gdG9nZ2xp
bmcgdGhlIFJGTEFHUy5BQyBiaXQgc2ltaWxhciB0byBTTUFQLg0KPiANCj4gRGVmaW5lIHRoZSBD
UFUgZmVhdHVyZSBiaXRzIHRvIGVudW1lcmF0ZSBMQVNTIGFuZCBhZGQgYSBkZXBlbmRlbmN5IG9u
DQo+IFNNQVAuDQo+IA0KPiBMQVNTIG1pdGlnYXRlcyBhIGNsYXNzIG9mIHNpZGUtY2hhbm5lbCBz
cGVjdWxhdGl2ZSBhdHRhY2tzLCBzdWNoIGFzDQo+IFNwZWN0cmUgTEFNIFsxXS4gQWRkIHRoZSAi
bGFzcyIgZmxhZyB0byAvcHJvYy9jcHVpbmZvIHRvIGluZGljYXRlIHRoYXQNCj4gdGhlIGZlYXR1
cmUgaXMgc3VwcG9ydGVkIGJ5IGhhcmR3YXJlIGFuZCBlbmFibGVkIGJ5IHRoZSBrZXJuZWwuICBU
aGlzDQo+IGFsbG93cyB1c2Vyc3BhY2UgdG8gZGV0ZXJtaW5lIGlmIHRoZSBzeXN0ZW0gaXMgc2Vj
dXJlIGFnYWluc3Qgc3VjaA0KPiBhdHRhY2tzLg0KPiANCj4gTGluazogaHR0cHM6Ly9kb3dubG9h
ZC52dXNlYy5uZXQvcGFwZXJzL3NsYW1fc3AyNC5wZGYgWzFdDQo+IFNpZ25lZC1vZmYtYnk6IFNv
aGlsIE1laHRhIDxzb2hpbC5tZWh0YUBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBCb3Jpc2xh
diBQZXRrb3YgKEFNRCkgPGJwQGFsaWVuOC5kZT4NCj4gUmV2aWV3ZWQtYnk6IFhpbiBMaSAoSW50
ZWwpIDx4aW5Aenl0b3IuY29tPg0KPiAtLS0NCj4gdjEwOg0KPiAgLSBEbyBub3QgbW9kaWZ5IHRv
b2xzLyoqL2NwdWZlYXR1cmVzLmggYXMgdGhvc2UgYXJlIHN5bmNlZCBzZXBhcmF0ZWx5Lg0KPiAt
LS0NCj4gIGFyY2gveDg2L0tjb25maWcuY3B1ZmVhdHVyZXMgICAgICAgICAgICAgICAgfCA0ICsr
KysNCj4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggICAgICAgICAgfCAxICsN
Cj4gIGFyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vcHJvY2Vzc29yLWZsYWdzLmggfCAyICsrDQo+
ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L2NwdWlkLWRlcHMuYyAgICAgICAgICAgIHwgMSArDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L0tjb25maWcuY3B1ZmVhdHVyZXMgYi9hcmNoL3g4Ni9LY29uZmlnLmNwdWZlYXR1cmVzDQo+
IGluZGV4IDI1MGMxMDYyN2FiMy4uNzMzZDVhZmYyNDU2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni9LY29uZmlnLmNwdWZlYXR1cmVzDQo+ICsrKyBiL2FyY2gveDg2L0tjb25maWcuY3B1ZmVhdHVy
ZXMNCj4gQEAgLTEyNCw2ICsxMjQsMTAgQEAgY29uZmlnIFg4Nl9ESVNBQkxFRF9GRUFUVVJFX1BD
SUQNCj4gIAlkZWZfYm9vbCB5DQo+ICAJZGVwZW5kcyBvbiAhWDg2XzY0DQo+ICANCj4gK2NvbmZp
ZyBYODZfRElTQUJMRURfRkVBVFVSRV9MQVNTDQo+ICsJZGVmX2Jvb2wgeQ0KPiArCWRlcGVuZHMg
b24gWDg2XzMyDQo+ICsNCg0KQWxsIHRoZSBvdGhlciBvbmVzIGluIHRoZSBmaWxlIGFyZSAhWDg2
XzY0LiBXaHkgZG8gdGhpcyBvbmUgWDg2XzMyPw0KDQo+ICBjb25maWcgWDg2X0RJU0FCTEVEX0ZF
QVRVUkVfUEtVDQo+ICAJZGVmX2Jvb2wgeQ0KPiAgCWRlcGVuZHMgb24gIVg4Nl9JTlRFTF9NRU1P
UllfUFJPVEVDVElPTl9LRVlTDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9j
cHVmZWF0dXJlcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiBpbmRl
eCBiMmE1NjIyMTdkM2YuLjEyODNmM2JkZGEwZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVm
ZWF0dXJlcy5oDQo+IEBAIC0zMTQsNiArMzE0LDcgQEANCj4gICNkZWZpbmUgWDg2X0ZFQVRVUkVf
U000CQkJKDEyKjMyKyAyKSAvKiBTTTQgaW5zdHJ1Y3Rpb25zICovDQo+ICAjZGVmaW5lIFg4Nl9G
RUFUVVJFX0FWWF9WTk5JCQkoMTIqMzIrIDQpIC8qICJhdnhfdm5uaSIgQVZYIFZOTkkgaW5zdHJ1
Y3Rpb25zICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FWWDUxMl9CRjE2CQkoMTIqMzIrIDUp
IC8qICJhdng1MTJfYmYxNiIgQVZYNTEyIEJGTE9BVDE2IGluc3RydWN0aW9ucyAqLw0KPiArI2Rl
ZmluZSBYODZfRkVBVFVSRV9MQVNTCQkoMTIqMzIrIDYpIC8qICJsYXNzIiBMaW5lYXIgQWRkcmVz
cyBTcGFjZSBTZXBhcmF0aW9uICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0NNUENDWEFERCAg
ICAgICAgICAgKDEyKjMyKyA3KSAvKiBDTVBjY1hBREQgaW5zdHJ1Y3Rpb25zICovDQo+ICAjZGVm
aW5lIFg4Nl9GRUFUVVJFX0FSQ0hfUEVSRk1PTl9FWFQJKDEyKjMyKyA4KSAvKiBJbnRlbCBBcmNo
aXRlY3R1cmFsIFBlcmZNb24gRXh0ZW5zaW9uICovDQo+ICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0Za
Uk0JCSgxMiozMisxMCkgLyogRmFzdCB6ZXJvLWxlbmd0aCBSRVAgTU9WU0IgKi8NCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20vcHJvY2Vzc29yLWZsYWdzLmggYi9hcmNo
L3g4Ni9pbmNsdWRlL3VhcGkvYXNtL3Byb2Nlc3Nvci1mbGFncy5oDQo+IGluZGV4IGYxYTRhZGM3
ODI3Mi4uODFkMGM4YmYxMTM3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkv
YXNtL3Byb2Nlc3Nvci1mbGFncy5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20v
cHJvY2Vzc29yLWZsYWdzLmgNCj4gQEAgLTEzNiw2ICsxMzYsOCBAQA0KPiAgI2RlZmluZSBYODZf
Q1I0X1BLRQkJX0JJVFVMKFg4Nl9DUjRfUEtFX0JJVCkNCj4gICNkZWZpbmUgWDg2X0NSNF9DRVRf
QklUCQkyMyAvKiBlbmFibGUgQ29udHJvbC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xvZ3kgKi8N
Cj4gICNkZWZpbmUgWDg2X0NSNF9DRVQJCV9CSVRVTChYODZfQ1I0X0NFVF9CSVQpDQo+ICsjZGVm
aW5lIFg4Nl9DUjRfTEFTU19CSVQJMjcgLyogZW5hYmxlIExpbmVhciBBZGRyZXNzIFNwYWNlIFNl
cGFyYXRpb24gc3VwcG9ydCAqLw0KPiArI2RlZmluZSBYODZfQ1I0X0xBU1MJCV9CSVRVTChYODZf
Q1I0X0xBU1NfQklUKQ0KPiAgI2RlZmluZSBYODZfQ1I0X0xBTV9TVVBfQklUCTI4IC8qIExBTSBm
b3Igc3VwZXJ2aXNvciBwb2ludGVycyAqLw0KPiAgI2RlZmluZSBYODZfQ1I0X0xBTV9TVVAJCV9C
SVRVTChYODZfQ1I0X0xBTV9TVVBfQklUKQ0KPiAgDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2NwdWlkLWRlcHMuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY3B1aWQtZGVwcy5j
DQo+IGluZGV4IDQ2ZWZjYmQ2YWZhNC4uOThkMGNkZDgyNTc0IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L2NwdWlkLWRlcHMuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1
L2NwdWlkLWRlcHMuYw0KPiBAQCAtODksNiArODksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNw
dWlkX2RlcCBjcHVpZF9kZXBzW10gPSB7DQo+ICAJeyBYODZfRkVBVFVSRV9TSFNUSywJCQlYODZf
RkVBVFVSRV9YU0FWRVMgICAgfSwNCj4gIAl7IFg4Nl9GRUFUVVJFX0ZSRUQsCQkJWDg2X0ZFQVRV
UkVfTEtHUyAgICAgIH0sDQo+ICAJeyBYODZfRkVBVFVSRV9TUEVDX0NUUkxfU1NCRCwJCVg4Nl9G
RUFUVVJFX1NQRUNfQ1RSTCB9LA0KPiArCXsgWDg2X0ZFQVRVUkVfTEFTUywJCQlYODZfRkVBVFVS
RV9TTUFQICAgICAgfSwNCg0KQWhhISBTbyBTTUFQIGlzIHJlcXVpcmVkIGZvciBMQVNTLiBUaGlz
IG1ha2VzIHRoZSBzdGFjL2NsYWMgcGF0Y2ggbWFrZSBtb3JlDQpzZW5zZS4gUGxlYXNlIHRob3Nl
IGNvbW1lbnRzIGxlc3Mgc2VyaW91c2x5LiBBbHRob3VnaCBJIHRoaW5rIGEgY29tbWVudCBpcyBz
dGlsbA0Kbm90IHVud2FycmFudGVkLg0KDQo+ICAJe30NCj4gIH07DQo+ICANCg0K

