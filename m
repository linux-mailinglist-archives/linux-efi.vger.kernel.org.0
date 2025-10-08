Return-Path: <linux-efi+bounces-5005-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57DBC613E
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 747504E9F6B
	for <lists+linux-efi@lfdr.de>; Wed,  8 Oct 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D99261B70;
	Wed,  8 Oct 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8ZgYTlw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298D7260A;
	Wed,  8 Oct 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942345; cv=fail; b=E54/tcGMM/gQ5sh3RU+5oWzfODi9d97jXq2VJ9ZAPh2yn6gg0Xwzp8qr7/lrua0b8EIZP3KiSCzGWzBlZAv6LYJmpK2irhnf4uDk3RXpvsEQWVBXpr9uk+kSYIV0mJpWd2gxIFN4sB2qkGsPpL/t4eywdbT+oqA3jQ4doOkjIIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942345; c=relaxed/simple;
	bh=sPlAec6FSQPqqmy2OuK+VWFUaj+xYp2gOOfzEJUuIZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4y5HRs6F+QBtY1Qpg3yQia2P1EGTGN0Vx/IIc1Gkx94z1OUXNXkRmTJm/9yn52xkWTWi8q8ntzS62lkqzV5yrF7hw1/K2hUVt3b1xxnA23svZSOVtNKQ3yYj6MiSTYjgzYIUxZIr2y5AaPh/IKEKPg0YQqv7ya1LKEGDDDzDjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8ZgYTlw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759942344; x=1791478344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sPlAec6FSQPqqmy2OuK+VWFUaj+xYp2gOOfzEJUuIZs=;
  b=d8ZgYTlwFW+U6cQfFvX/lizYVYjJq5qdKzFw/qV9Gv+uLiol1fPvrcwe
   NDZ8pluAmD5HOLaEJ6GJ2dL1Fb0q0/yaKeVse381VDqCfawqJxr09mBmk
   P74R5Bdvpbc+mxIbncWAqXl+sW+UwYL4/0dgOw4Dbb4LiXq970kXHnIV0
   mbwC6IsLllXy/sxegkeylxnEB2MozsHmVXIX3G4jVZU3g0AZqKmD5EJ4a
   2LqNu0nN6fRdedssW+olrP1S/0hRSzyh0SNYErQ+1/OEsyiJEowoyvzEb
   YDk64RdMiuRV7FHKsfWNeXUuSsQLkcBLwXXxo8lyJhE2upHEEvuQULxzf
   Q==;
X-CSE-ConnectionGUID: SFc+eCx9QN+dESsmz2tBCg==
X-CSE-MsgGUID: u2i1XkQqToiMSx8/sCnKMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62030481"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="62030481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:52:23 -0700
X-CSE-ConnectionGUID: WUVyOd/xRQyN5EZUdljULA==
X-CSE-MsgGUID: C2lYSwEjTi6vjWLShOqVtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="185613751"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:52:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 09:52:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 09:52:21 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 09:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLp633SWwjOYfdBt93fc2lCJYNfueiDiaZQK2lbgr94ijA5McyK1lnqfIvn0DQG8I9gPhok/QanItdIwwyUROUPSlP8WV2wto8r+8VkD63BArR6Ph3+ydW3AHAGc6FsUCB9H69hp1vBM3Jyi2y6p7EuDFiqJwmyo+zZ67/aAlf55vr3tpDfh0aBMGtNBsBz/IlLdQdJw4U461zfC1zgrIBlYAeXwqIxgHZgV6zajUH0HR7k+RkKwihq+ce4pzzjTbxsBvM6koxfe5h2D+DGecLXfHMpBNWtniHx/ehqiw/+LKtejg1E5ZDNHlr/6bCN9XWdwkqzjBw4skSZ0N414fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPlAec6FSQPqqmy2OuK+VWFUaj+xYp2gOOfzEJUuIZs=;
 b=a99ggeMA05uZRyCwbXucnhE4pZ730uf5mik9nznWG1g4BYcncIs8ue+INW1lYamIX/XscpplzIZYq2QxaCEicsCk8nyP2uUK6uChOIHw6cpV06VphFu74ZogIMUXws8RK2Byr6jnTLQiu4W49XZSM98gce0aOgWGRskA9IZAUu5OruAkrqcJtlEb4OMKWpiNqGMRmqXMR3VtPe1cmQ2ZVi7wEVWri0f/fLezfH4We9Mik3W287p/MrrkVSbWK8RTBstE7F4lpxLdDv/WOZetZbgxK1UAUlLgvnJjPgpgXk1lNe/NfLHrxElZoS8vPWaO89FWIKbmOI7IlsCibqWB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) by
 CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 16:52:14 +0000
Received: from DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79]) by DM4PR11MB5970.namprd11.prod.outlook.com
 ([fe80::e9b1:6f0f:1a91:2c79%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 16:52:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, "xin@zytor.com"
	<xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Thread-Topic: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Thread-Index: AQHcN1cw4DZ66oVJo0SQ3van2Zqe3LS3AG+AgABQaYCAAShDgA==
Date: Wed, 8 Oct 2025 16:52:14 +0000
Message-ID: <66212761b9ef76b209e83e08c9258b76f51dbebc.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-5-sohil.mehta@intel.com>
	 <e873d2b06a18b69e246f8011c556259d21c7e022.camel@intel.com>
	 <7635c45d-97b3-4773-95db-e61ad872ce22@intel.com>
In-Reply-To: <7635c45d-97b3-4773-95db-e61ad872ce22@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5970:EE_|CY8PR11MB7290:EE_
x-ms-office365-filtering-correlation-id: 288f03bb-97c0-4478-70c8-08de068b086e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RXN6Yk1NWE5LaG5UUCtVb1I2RVIxY1dxOG5FbUVKWnpPR1UyeDFBT1ByNHA4?=
 =?utf-8?B?TGhVaDkzRnNON1NrRlZXamFkeklheVlFYi91MkdOU0hMbmVQYnFxWlFwRDN3?=
 =?utf-8?B?SGVkRkZBOUE2QURlNkFYcVlYVUxIT3JKN3BqaXNJMWdvV0xRWURvT1NDSXJn?=
 =?utf-8?B?YjJUbExJYVR6QXFFZ1ljNVN5ZEFXWlp0VFIzTGdWeDFRZnZjRXRmVGFsd0JC?=
 =?utf-8?B?THpyQzh3V2kzdGVUdGJoMlgycFkrcnlvRlhzVElqZXVEcjZEeHFuUWhYRzZy?=
 =?utf-8?B?VElBdFptbGM4YnROaVcvd3lGMG0vS2FYSHJmWTFxZDkwLzkyN3hBWHJqNFdj?=
 =?utf-8?B?NHVFU0VRQVdjRXNxdjFJWEVFRGxNRld2RWVTbWp0RzFNUllYUlJHWkhmTzdr?=
 =?utf-8?B?UzFwSnFUZzNraDliV0FvdWZTaWwwc3l6MnRGOXc1ZHl2U1VTdzZNc3RHdHZz?=
 =?utf-8?B?SWpFemdIeVVFUlA2L3pYYzdoVi9jZUhFUTd4TldEV1hWSXpxNThYWDhjdzRT?=
 =?utf-8?B?QjdIS0tuTjVwanJtZStoSnB4aVhVVkx1YXZzRmpjRjMrdFkzZ25IeUgvV0Ez?=
 =?utf-8?B?eGZrNmJOaDFkSEhmY0wwaXBBNkZUd3dqUFY5Y040bzNLVUZrTGFHTXpsdXdx?=
 =?utf-8?B?bTRNcXFMT2JCcG0zdWp6WE1kL0Z6aU1qMm9NMEl2RGtqUWx4bkZBQmxCdHAr?=
 =?utf-8?B?NENsc1BWM2VQWmt0WjZwcWI3QnU2NWw4L1hHaXlzcms0ckRuQ2orbFdQWFJl?=
 =?utf-8?B?Wmthek5RdnJkeEMyRzFNQm9HUzgxdzBWbHJ5aFZzTjR5RVNNZVhrenR2c1BM?=
 =?utf-8?B?RmIxSTBUNTMrSC9jdXo3ek11cWtMcFBxYVZ1ZkdLb3hBd0xseHkvQzdHZjc1?=
 =?utf-8?B?dENkM0xkUi9UcGxDYWFxQ2lNOXR1R2pXVStiWVVjckNXeUR1eUtDNFN4L25N?=
 =?utf-8?B?VGZQdExwSERsTE9vMUpRaEJsWW5iOXB1MC9SUjZVcjdFcDVVRXZmOUsrVUxi?=
 =?utf-8?B?ZTB0REtGWEx2WUFOS3A0emdkOThhbktLd3FXOUxMMkJEUy9uK3Q4NDFsV1FD?=
 =?utf-8?B?RE5FUG9WZ08vSC82bG51aGZjR1Avazl6cjJybFdQL3lxZzZPS0Y3akxuS3lu?=
 =?utf-8?B?NWkvcDcvZjJZOFdXTExJTzB3b3VjaXdRdnlVSXdiai9KdHZXV3llekJpMWNi?=
 =?utf-8?B?RGp0WWdTZ2J3WSt4STM3SW5zOG9OU1ROcGJrRVZFVy90d0pnbDdtSStkL2lt?=
 =?utf-8?B?UERoR0pVbEpEUmd4L3J6NUNRTmNvRnk4em82Nmt0NFJTWFNaeU1wNGhRNGY5?=
 =?utf-8?B?Nm5FeEdjRVNNSjQzWmlvcHdQV2dUVzRTZ0RHQnM3L3dFdFVmanIrNXluaElR?=
 =?utf-8?B?WENWcU9Sd2FIajdkZWdOendOUGpiK1gwbk4rYWJqQVRGbEdkRlNKaXdrUzNT?=
 =?utf-8?B?UjRjWjhHRm9tV0s1eVlJcys4OEtPUzBEbUFYR29RbnpDNmpuMVd2T0tmbHRr?=
 =?utf-8?B?UDg5WktERUNYRGZjZWxSVUNlcW1OTldqN2FEbitHazBMSzJiOTFFbEcwMUh5?=
 =?utf-8?B?NWZDSUEzR1V1UjVSZVFrME9mZDllR2RoTW5nVHdUczBJbFpmZG0vSnRjTWNZ?=
 =?utf-8?B?WHNYOTNhczdzbW9iWDAwSUhNQW1tVndIczJMUTE2YWwxOG9zVnRONmpMSnpP?=
 =?utf-8?B?WncvcHNwT0l4V3B0bDZKWi9nN1lDYmhjWmdsKzZrVFU1azRPbVIrYmVNUW5E?=
 =?utf-8?B?RnRQUEFyeThzc3h0QWlvT0tPNm4wV2g3Tk1ZVnVrNGNjT2JaWDBGemVjQVFD?=
 =?utf-8?B?ZmJyZEE1NXdIYnc3TWJ1MmFiUFBPQ29waUtUeCs0aUdNdW10blN4MmdPQ1hF?=
 =?utf-8?B?NTdoZ2xQMTBBVHhXUXZzZWQ0YmtXWkFMTElScmhIY3N2U09rMFdKVGU0Wk5V?=
 =?utf-8?B?SGMrb1E1aFdlc2NGVEUxbnp4WmgwcndETFhlam12RWMwalJzdTJkZDZTMnVR?=
 =?utf-8?B?eXdqL3RZWVJmT3RKOTRWbzdERE45ampZVjRhM2JhVjRGMWZ5L1Btb2I4YlRq?=
 =?utf-8?Q?9MPFtd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5970.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNsV1RCRWd2TElSQjNJTjZraS9CZ0wvQkh0MisrVmhwWVFNRk9GLytkOGY0?=
 =?utf-8?B?Yi9OTjRrSjZldHpWSkZBT3R1WFNCUHdpZGR2YkpXa3hCREhOWkVqM1k0anB2?=
 =?utf-8?B?cmJkVDUxcUNXbi80R0xzd3FXWWFnOTVXU2Jsa3NXamFJTWc4MEZWUlVGVVo5?=
 =?utf-8?B?b2Rpdlp3aTFQQ29Wb0hZa2xKODN1NnBxTXNIeHBVSGZUSkFaWnRDZnJvcmhQ?=
 =?utf-8?B?WlJCdnU3R1RMYXVoM0NvYVBJa0E0b2E3a3A5S0ZJdkpHUXh1Q1YzVkhENm93?=
 =?utf-8?B?RDgreW16MVlDRU1GajlaUTlNQUpHR2NFeFJjSW9meU9YMnQrUjdLaFd2cFZu?=
 =?utf-8?B?VUtMQi91ZHFESjVjNlJUbmpTSVBTb0sxbE8xM0JUWnRpUHVLbGU4a01PS1hY?=
 =?utf-8?B?WWRWSUhyN2VmWFk0MGVBeEE3bzUrdDlUa2tMbHc5Tk5LUmhraG13aDdSQUtt?=
 =?utf-8?B?blpTeTZUWmdmMUtNWEdoS3NEbS9WUUVnYjlFNVZ0N3lGTEp6MDg2SDR5aExk?=
 =?utf-8?B?eWRXTURMS1NXSVU4aWhJTDVOSExpTFFOSFpBektPZi9hazFHdGprWFVFL2RJ?=
 =?utf-8?B?WUh5L2RGcnUwOU1VQ1lVdHEvVDdyTS83OXlQd1dLTUR5blNMWHdWSXhrWWli?=
 =?utf-8?B?OURiL0xPZUorYTNzeVFjWlJUQXhYZ0krbW41MTBUNzlmbmdxeWtIQmpmbTdF?=
 =?utf-8?B?MVJMMzcwbmRSMXdWalVxampSL2hpUis0azE3aW1aa3ROOGh0MCttd3M0VDZu?=
 =?utf-8?B?K09wTGkrOTBUU0dad1B0cFViUFFHVmhTdnBtSE5LZDBDbFhiK2pRUXhyMUxs?=
 =?utf-8?B?TlJIdkViZEZBZHE3TWRFeVJpRitzM2dIN1JmZlJBWlFHbVZENzJKNVFaa3dP?=
 =?utf-8?B?aStWcksrTmtqS3ZpVFJzYUVoT21VK0RJSHd4cFhnNm5rWTl5bEtaZERkcG5v?=
 =?utf-8?B?c3RWMGhBLzBydTFUU1FpQUlOZ1ZzamtYUzNlMENxTlhCeEpJaVlSWnduMTlu?=
 =?utf-8?B?WFZyaGhUOGJXankwb0pVSU53VEFxeDhMcyt0Z1hCSVE0c0RhaGhWUnloNFUv?=
 =?utf-8?B?WHhGNy9yNlhLaS91ZXh2dUVxUXNWV3d0aGpCSEtwNWRaYm9ZUkNrRkNtNGVU?=
 =?utf-8?B?Qi9tVjFPVzhwNDNBbjNGWXdTYnFDUEpqOVl3QzBQNi9JSmF1ZmlmeDU1ZlJt?=
 =?utf-8?B?V3hvTmxiNGRraThsNXN4VTBhQy84VWJGTW9uZDhoSyszUk9zY1ZubHJSNkZM?=
 =?utf-8?B?bFpPVDBRTituU0NJRFg2dFNNWEZONFRTSFlWWkNsZ05UOWtSckVWU0gxUW9E?=
 =?utf-8?B?YmY2UllxM1lEL3hQelJtWVUrYVo3V1ZFcm5JZytyZmxNMk4wNHUwL1dmQzFB?=
 =?utf-8?B?T3BRRG1uYkR4S1M4MDExL0hUYmllS3IrS2F2ZGZKdyswVEoyOU9TVTZXbEVl?=
 =?utf-8?B?OFBBNnZLNHVnamV6YUMzb0paTHVRa0VaM3J2TEdrcEoxQzc3MUk3YVBHWnJn?=
 =?utf-8?B?VE9lVkIxdXE1cFdpdkNaZEhicXdJUEtrZVN0LzRZMzc5NG9wN1RSWW9Ec1hr?=
 =?utf-8?B?SGRKbi81dkZHRnZCWk1VcjFwN25ob1RUYlliQ3JkL0E5QTA3S3VUOVNMdHdN?=
 =?utf-8?B?UlRocVlZQVJZQ3RUTmRDWHBNU09hNGJnUytzK3NYUGlIeTZUZkhGWTBCdnNi?=
 =?utf-8?B?a0NVYkVTajBXSWJXcjlpVzVadTNYcHU2allQQWxYcUtXTXQvOEk3RXNaaVho?=
 =?utf-8?B?R3pZc3hCTC9PdlBKM1pwbzhhTFVOa1dEQ0NEL3JOb0hldVFXOGIxY2VEWUU3?=
 =?utf-8?B?NzJTUUtSVy9UbVdrSCtXQzAzWlcyV0xiSDV2ekVudG1TV2phVDlxWkt3S2Va?=
 =?utf-8?B?SDJvcU1QbEZxZWs5VTF2L3V2akQ0cTljcUo1bWJPNjFueitZejdFMDdhOFEy?=
 =?utf-8?B?Z0tHc0doeUZvQ1FHZytrNTJ6VzlXN2F0cXc2QjZpdGZBQjNhSllVb0h6OWV3?=
 =?utf-8?B?M2dPaW5HT2hCRHRTeTEzaTZDd3NydW5yNjZVL1NnSTM2SnZtVjliVjNCa2s5?=
 =?utf-8?B?T0pxN2Q0Rzk0a2YvRWhyb0tzNW9hYTF3dk9BVUNUMzRtR215WFRWemxtL3E2?=
 =?utf-8?B?Q1pmY2tLWlBKakYyQlBGMFNJWjZaYW5DQlJybE8yYlZDV0MyRStNaTllejRy?=
 =?utf-8?Q?4LYsxuWSEXHj0MlAftO3lUM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10FB326792ECBC4E83F0879110B4EE8B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5970.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288f03bb-97c0-4478-70c8-08de068b086e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 16:52:14.4558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spUruZ8lJq4X4PioyleXq/rqxQOD0Oamv2QDDAfSiOdrSOiZLMdcqodVhPXQFhbRCX6UjB5w2tfKcbPcECz123EdrCbYaNTBoUoiG70gRo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7290
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDE2OjExIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
T24gMTAvNy8yMDI1IDExOjI0IEFNLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToNCj4gPiA+IFNl
Y3VyaXR5IGZlYXR1cmVzIHN1Y2ggYXMgTEFTUyBhcmUgbm90IGV4cGVjdGVkIHRvIGJlIGRpc2Fi
bGVkIG9uY2UNCj4gPiA+IGluaXRpYWxpemVkLiBBZGQgTEFTUyB0byB0aGUgQ1I0IHBpbm5lZCBt
YXNrLg0KPiA+ID4gDQo+ID4gDQo+ID4gSSB3YXMgZGViYXRpbmcgd2hldGhlciB3ZSByZWFsbHkg
bmVlZCB0aGlzLCBnaXZlbiB0aGUgTEFTUyBhbmQgQ1IgcGlubmluZyB0aHJlYXQNCj4gPiBtb2Rl
bHMuIENSIHBpbm5pbmcgc2VlbXMgdG8gYmUgYWJvdXQgYWZ0ZXIgYW4gYXR0YWNrZXIgaGFzIGFs
cmVhZHkgaGlqYWNrZWQgYQ0KPiA+IGNvbnRyb2wgZmxvdyBhbmQgaXMgbG9va2luZyB0byBlc2Nh
bGF0ZSBpdCBpbnRvIG1vcmUgY29udHJvbC4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGV4cGxhaW4g
bW9yZT8gSG93IGlzIExBU1MgZGlmZmVyZW50IGZyb20gU01BUCBhbmQgU01FUA0KPiBmb3Igd2hp
Y2ggdGhlIENSIHBpbm5pbmcgY29kZSB3YXMgaW5pdGlhbGx5IGFkZGVkPw0KDQpUaGUgbmV4dCBw
YXRjaCBzYXlzICJDUiBwaW5uaW5nIG1haW5seSBwcmV2ZW50cyBleHBsb2l0cyBmcm9tIHRyaXZp
YWxseQ0KbW9kaWZ5aW5nIHNlY3VyaXR5LXNlbnNpdGl2ZSBDUiBiaXRzLiINCg0KTXkgdW5kZXJz
dGFuZGluZyBvZiB0aGF0IGF0dGFjayBpcyB0aGF0IGF0dGFja2VyIGFscmVhZHkgaGFzIGVub3Vn
aCBjb250cm9sIGluDQp0aGUga2VybmVsIHRvIGNhbGwgQ1I0IHdyaXRpbmcgZnVuY3Rpb25zLCBv
ciBvdGhlcndpc2UgY29udHJvbCB0aGUgQ1I0IHdyaXRlLg0KVGhleSBkaXNhYmxlIFNNQVAgb3Ig
c29tZXRoaW5nIHRvIGhlbHAgZG8gUk9QIGZvciB0aGUgbmV4dCBzdGVwIG9mIHRoZWlyIGF0dGFj
ay4NCg0KSSAqdGhpbmsqIHRoZSBvYnNlcnZhdGlvbiB0aGF0IGxlYWQgdG8gQ1IgcGlubmluZyB3
YXMgdGhhdCBiZWZvcmUgU01BUCBhdHRhY2tzDQp3b3VsZCBwcmVwIGEgUk9QIGNoYWluIChzdGFj
aykgaW4gdXNlcnNwYWNlIG1lbW9yeSwgdGhlbiB1c2UgYSBmdW5jdGlvbiBwb2ludGVyDQpoaWdo
amFjayB0byBjYWxsIGEgZnVuY3Rpb24gdGhhdCBzd2l0Y2hlZCB0aGUgc3RhY2sgdG8gdXNlcnNw
YWNlIG1lbW9yeS4gQWZ0ZXINClNNQVAgdGhpcyB3YXMgYmxvY2tlZCwgYW5kIGF0dGFja3MgaGFk
IHRvIGRvIHRoZSBsb25nZXIgc3RlcCBvZiBmb3JtaW5nIGFuZA0KZmluZGluZyB0aGUgUk9QIHN0
YWNrIGluIGtlcm5lbCBtZW1vcnkuIEJ1dCB0aGVuIHNvbWUgb2JzZXJ2ZWQgYXR0YWNrcyB3ZXJl
IGp1c3QNCmZpcnN0IGNhbGxpbmcgQ1I0IHdyaXRpbmcgZnVuY3Rpb25zIHRvIGRpc2FibGUgU01B
UCBhbmQgdGhlbiBjb250aW51ZSB0aGUNCnVzZXJzcGFjZSBiYXNlZCBhdHRhY2sgbGlrZSBub3Jt
YWwuIFNvIENSIHBpbm5pbmcgY291bGQgYmxvY2sgdGhpcyBhbmQgZm9yY2UNCnRoZW0gdGhlIG90
aGVyIHdheS4gVGhlbiBhcyBsb25nIGFzIHdlIGhhZCB0aGUgaW5mcmFzdHJ1Y3R1cmUsIGFueSBD
UiBiaXRzIHRoYXQNCm1pZ2h0IGhlbHAgd2VyZSBhZGRlZCB0byB0aGUgbWFzayBiZWNhdXNlIHdo
eSBub3QuIChJIHRoaW5rIHRoaXMgaXMgdGhlIGhpc3RvcnksDQpidXQgcGxlYXNlIGRvbid0IHRh
a2UgaXQgYXMgYXV0aG9yaXRhdGl2ZSkNCg0KT3ZlciBTTUFQLCBMQVNTIGhhcyBzcGVjdWxhdGl2
ZSBiZW5lZml0cy4gVXN1YWxseSBhIHNwZWN1bGF0aXZlIGF0dGFjayBkb2Vzbid0DQppbnZvbHZl
IG5vbi1zcGVjdWxhdGl2ZSBjb250cm9sIGZsb3cgaGlnaGphY2suIElmIHlvdSBhbHJlYWR5IGhh
dmUgdGhhdCwgeW91DQpwcm9iYWJseSBkb24ndCBuZWVkIHRvIG1lc3Mgd2l0aCBhIHNwZWN1bGF0
aXZlIGF0dGFjay4gKGhhbmQgd2FpdmluZyBhIGJpdCkNCg0KU28gSSB3YXMgdGhpbmtpbmcgdGhh
dCB0aGUgQ1IgcGlubmluZyBvZiBMQVNTIGRvZXNuJ3QgcmVhbGx5IGhlbHAgdGhhdCByZWFzb25p
bmcNCmZyb20gdGhlIG5leHQgcGF0Y2guIEFuZCB1bmxpa2UgdGhlIG90aGVyIGJpdHMgdGhhdCBq
dXN0IGdvdCBhZGRlZCBlYXNpbHksIHRoaXMNCm9uZSByZXF1aXJlZCBpbmZyYXN0cnVjdHVyZSBj
aGFuZ2VzIGFuZCBleHRyYSBwYXRjaC4gU28gd29uZGVyZWQsIGhtbSwgaXMgaXQNCndvcnRoIGl0
IHRvIGRvIHRoZSBleHRyYSBwYXRjaGVzPw0KDQo+IA0KPiA+IFdlIGNvdWxkIG1heWJlIGdldA0K
PiA+IGF3YXkgd2l0aCBkcm9wcGluZyB0aGlzIGFuZCB0aGUgZm9sbG93aW5nIHBhdGNoLiBCdXQg
aXQgd291bGQgc3RpbGwgYmUgZ29vZCB0bw0KPiA+IGdldCBhIHdhcm5pbmcgaWYgaXQgZ2V0cyB0
dXJuZWQgb2ZmIGluYWR2ZXJ0ZW50bHkgSSB0aGluay4gSXQgbWlnaHQgYmUgd29ydGgNCj4gPiBh
ZGRpbmcganVzdGlmaWNhdGlvbiBsaWtlIHRoYXQgdG8gdGhlIGxvZy4NCj4gDQo+IE15IHVuZGVy
c3RhbmRpbmcgZnJvbSB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbnMgd2FzIHRoYXQgQ1IgcGlubmlu
Zw0KPiBkZWZlcnJhbCBtaWdodCBiZSBiZW5lZmljaWFsIGluZGVwZW5kZW50IG9mIExBU1MuDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYzU5YWE3YWMtNjJhNi00NWVjLWI2MjYtZGU1
MThiMjVmN2Q5QGludGVsLmNvbS8NCj4gDQo+IFRoZSBwaW5uaW5nIGVuZm9yY2VtZW50IHByb3Zp
ZGVzIHRoZSB3YXJuaW5nIGFuZCByZXByb2dyYW1zIHRoZSBiaXQuDQo+IE1heWJlLCBJJ3ZlIG1p
c3VuZGVyc3Rvb2QgeW91ciBjb21tZW50Lg0KPiANCg0KWWVhLCBJIGFncmVlIGl0IHdvdWxkIGJl
IGdvb2QgdG8gZ2V0IGEgd2FybmluZy4gVGhlIHdyaXRlIG1heSBiZSB0cmlnZ2VyZWQNCmFjY2lk
ZW50YWxseSBieSBhIGtlcm5lbCBidWcuIEkgYWdyZWUgd2l0aCB0aGUgcGF0Y2gsIGJ1dCBqdXN0
IGNvbW1lbnRpbmcgbXkNCnJlYXNvbmluZyBmb3IgdGhlIHNha2Ugb2YgZGlzY3Vzc2lvbi4gTWF5
YmUgd2UgY2FuIHRpZ2h0ZW4gdGhlIHJlYXNvbmluZyBpbiB0aGUNCmxvZy4gSSB0ZW5kIHRvIHRo
aW5rIHRoYXQgaWYgSSBoYXZlIHRvIGdvIGludG8gYSBsb25nIGNoYWluIG9mIGFuYWx5c2lzIHRv
DQpkZWNpZGUgSSBhZ3JlZSB3aXRoIHRoZSBwYXRjaCwgdGhhdCB0aGUgbG9nIHNob3VsZCBoYXZl
IGhlbHBlZCBtZSBnZXQgdGhlcmUuIE9mDQpjb3Vyc2UgdGhpcyBjYW4gYWxzbyBqdXN0IGJlIGJl
Y2F1c2UgaXQgd2VudCBvdmVyIG15IGhlYWQuIFBsZWFzZSB0YWtlIGl0IGFzIGENCnNvZnQgY29t
bWVudC4NCg==

