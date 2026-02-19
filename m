Return-Path: <linux-efi+bounces-6190-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIguGYR6l2mlzAIAu9opvQ
	(envelope-from <linux-efi+bounces-6190-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 22:03:00 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C32D016284C
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B217300AB35
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F4930DD3B;
	Thu, 19 Feb 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUiSlpRg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF71285071;
	Thu, 19 Feb 2026 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534977; cv=fail; b=SMk37Yai1bmZ38rrAmdxUE7NTdX3yRiKUf0p4YGJz9sXxdg/gqCk1BAGcQFoNyiq9x29KY6K7VGU83ZYgiHAubOEvaYH34+Ai7CNhmWbkpBKchD9REkq7PzEycQubDvmJpnlRxC5zvFqUdLXcYpq8vU4rvv2u9uPKjb1hs3caBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534977; c=relaxed/simple;
	bh=86SfqgYzBSlyWNiKVC3DwkXiP7C7LU2jRaHbUfbMMXo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qESNxbgAcUDVSFNLei+xlI6rCkyPMqzDazvACQRNy5maMXBHPS7hSCbJUGrvoJmWGfXwTDMjYCzJGoWjdBeAp0YQ8Za6zJprF/yJ10tcyOHAyyYisIHbeUEQOqJYD1d6ekue1ECw5zbdkhxbTsrvtsW0O89FLn1bbGXxrrJQIMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUiSlpRg; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771534975; x=1803070975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=86SfqgYzBSlyWNiKVC3DwkXiP7C7LU2jRaHbUfbMMXo=;
  b=ZUiSlpRgUNZnw2oYmCGBxJdA6YO75cGnVJxQgP3gjqUIj/CzLOmjAXDY
   PscNmne9F9k48Iym+o8eMVrhZ4MaNa37pEuEzKMdfkFGY5EilGQBg0etm
   wMmldRO+1wKWIYwvrxfzCNwt/qeiz8c6uUvP5XrGLVI3peZzpwy+KwRW+
   uYMv2E4QPmIlE3CWuF5KDzM0CWP4X00ZLJYUKwZ6yNS+skp7mnYKtgvk0
   dthhVgTJF4ry97Ly3qW9STJIZ8EUVYzLFnlUgfvzOQu1fjkpn9P7XtgXB
   tl1bBn76nZvOna7dNkEOTkthaXFxrekf8Vi2VX1tJJdpzSeTCULv3rGqV
   g==;
X-CSE-ConnectionGUID: 9ImjOYD8QH63GY1cTeGgpQ==
X-CSE-MsgGUID: V+QEwZjvSQKNfd4YAgHYdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83257161"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83257161"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:02:54 -0800
X-CSE-ConnectionGUID: Zud8BTtETx+zRtj3u698sg==
X-CSE-MsgGUID: KBfW2f+qRPSOyzb2E8zIVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218799403"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 13:02:54 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 13:02:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 13:02:53 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 13:02:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZxrflJipp822TW15+TrCOQ89laW6PcgMl3eGgQ4+lfP/PwN2dN6bbyOxunU5ooPd6dQLXqOQzwRHgFmZWMuEKC0mq4R8gl7uWuV1Z0M59VH+9NwObWA4HXqMmi1Y4Fc636zqLL8x+5A02ei08V5BZTLIz31yB+ycJP2thts0gbc1E0LBg/r7sEeetu3sYzpJ5Tl6P38qVqO/6VK2mAlZ9HLpAar0iLrURyOb8g6Qpwzv6yrn8pvbdGtSMNjreZEHS/mI+2X/8JDlARdzJOfr8Qf3gMJVF9QueU7K1sZyC5t6fdcOiaCYYzocuEg5K3Fzm4ZEZhU+BJdCiAkhwVwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onmlckDsX/oz2BanswVmvWZvL/YDgeVbBwQiZxAaS+4=;
 b=BRdagz8OuEjIjPAmGXRVZ7AlZaUVOS3MBGS6CNVYKUxKWhNVmFJzYY0xqAAJRyfaBelCc3UvpXzfMbtjXUTGcv7ElanPcwUTbEfQ9xusEBdtHgDKuGHgqoPlGBqvqkmIOyHezFBTi2ZqW8PqLFZ2dWsTnQ5aeQ0INHVYem/zLbW+XmuzEkszLkKFhqip0SS+1jBAndqPVyqHAWe2SxPyQrg3kS7u5lWfWQsjXky1l+mqTAFzCzVjBz3F7pm8rbJa0mELptzfPVhnd858OCOaQny6f+WU5aX5OZtS5SrXcTNHHpF+6f7rMvMJu341thnMu820FFbveZk02KBoqkmrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH3PR11MB8095.namprd11.prod.outlook.com (2603:10b6:610:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 21:02:46 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 21:02:46 +0000
Message-ID: <ee807044-42f7-4fe5-9304-588a93a24656@intel.com>
Date: Thu, 19 Feb 2026 13:02:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/cpu: Defer LASS enabling until userspace comes
 up
Content-Language: en-US
To: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, "Nikunj A.
 Dadhania" <nikunj@amd.com>
CC: "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov"
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20260120234730.2215498-1-sohil.mehta@intel.com>
 <20260120234730.2215498-2-sohil.mehta@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260120234730.2215498-2-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH3PR11MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 811f9dd7-f870-425e-d3f4-08de6ffa3b5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE9kMERSZ1J6NDZhOHhiTDVPSGVpcXdYMHI0MUNLQXl6QTBIa0VRbWNCMkR4?=
 =?utf-8?B?VGdKTDlIdms0UDcvQUFyU01MS3M3Zkx6alBzUGc1R2N6amJ1TVZpVjcyb3ZN?=
 =?utf-8?B?cHBXUS96U1AxZW83T2F2VG5Ja0VUbWxXMnQrdkpKYW42VkVzc010NkdEZmZ4?=
 =?utf-8?B?bXlQazY3MUVPaXlUZERJWnZCSlNURkRaUlpTbm96TFhkY05CTE0zYzNFOU5o?=
 =?utf-8?B?aGdMLysveWYwMExMTVpWMXRqZDJUMVlkeHFoeTNSVXZtR2g4d0xtaUJVRFJV?=
 =?utf-8?B?UURmZEplUTRFc1UxdmI5SFNOUEcrSmVJdDZoanpFd1RZRG1GZGRTczd6SklI?=
 =?utf-8?B?OGtyR1BBSUJQR3B2U0szd21RaTVTam1ERStJajdGNkw5RjFZN2pGeklpV1F5?=
 =?utf-8?B?MVlVenY0bjFtbUk4QVpkV3QwMEswVWVXNzB4ajBYV0kwZmVYVFpOa28zZFNk?=
 =?utf-8?B?dFR6Sm42V1lPbkh2QkEzK2xldTkrVDZ4MG9VV2MvWjNjVFRYYmczdS9JWHly?=
 =?utf-8?B?NEpqclp3Um1zdzlGZnBOSnBFU2g1KzJUWE04OFdtbGdnRTd2eWFhaFJvVHBN?=
 =?utf-8?B?L3RFdFd5bk9jZkRsVzdCemdsK3ZrZVFTYnpucWZEOUEvUXpMRDNJeU9GaWRj?=
 =?utf-8?B?c3dDc2ViQkdQRFZZaVMzSWlSeVRzY3lsZFRKSFhqeUdjMzZGWDIwUzIwOUIx?=
 =?utf-8?B?R1ZHc0dEcWJVeU1WODZ5QVljMkJyaUJLdGxBdnBGM2pDck1pVFBheEtleVZ6?=
 =?utf-8?B?YjU3UVFrVUluVWx6RXJNWjl2WWJnQndUTkpFMXVneFlBUU9ZMkxicFQ1R2hF?=
 =?utf-8?B?aFdEL3g2d2h4dlB6eERPdkdnV055eHplTDhiRWZUT3VjWWhmUnlPakxBOUUy?=
 =?utf-8?B?eGRsWEFGdTNEazNRajJhajRYaFdhRTZub3lMMmNlOFdkSlJXZzRKR05hYWsy?=
 =?utf-8?B?K1d5TTV2QjFQbjVZR05wbnFpK0xoOUQ1N0NzSzRURS8zMHlqdGZZSXFoRGpN?=
 =?utf-8?B?clBiRm1DL01zUnR4ZzQ3WFY1UjZ6WlFINU5OcmgvMmxmb3VvWXI5MWJ0WkYw?=
 =?utf-8?B?c3UxeXVHV0NHTCt6QlFzc1FuQm5ad21tUjBqbnlQbFNOdHdabTk0dlpNMXRj?=
 =?utf-8?B?cGVybXcwbzNmSGhaelFaSmNxbm96cjZUVmUrTVZBbURLRC9FYzdNQlFsL0xC?=
 =?utf-8?B?VVAvMzY4WG1zWnRQWjZ0NDZpbEVlZnhqeFBseGtYVGhyZ25zOUhOR0Z3Q2Vx?=
 =?utf-8?B?QVZ2MlQrTkZMUFVWcHlOU0p5VmltY1MzZDFWSzJWMEEwbUpLeVo3NTI0NFBJ?=
 =?utf-8?B?WUtaTzhKQ2MyM3hSR3NmZzEyYTQ0VldENDVIZkhyNDl5M3g5dTZ0ZDVpR3Uz?=
 =?utf-8?B?RHhwWnBuMkhtUkVYRGdDVU5rM2FleTNvTjRoemlDdDYyZkc3MjRFNVRHandW?=
 =?utf-8?B?bEdmb2Vhdm1CUkphZmMva3hMZWRCVlNJM0RONVRxV3l1c2pIR1BUUGRldWZG?=
 =?utf-8?B?UzJhalhPZGdaOHdzTXFyMmJsVnpSenZmRk9lUWV6SkxNSmdpbGZoY3VOL1l3?=
 =?utf-8?B?cHNOYXhNSXJIcmp3Q04vRmNTMTllb2hucEtVTWZPYXhucjAzQ1pTcDR1R0VZ?=
 =?utf-8?B?OFNMNlRqWGUwQmhrTk8wRWVzN1FZVm9GaWZhMktOVkQzWkdIYnZEaklHYnZR?=
 =?utf-8?B?bUVuVmNpOFN0RTZaT1R6TnFpR2JMNnNldXQ4K0VneEVsZDJycGpCKzVaZCtX?=
 =?utf-8?B?MVF0NjBRZUEyTlFDNHluRkk2bG92YTlRQ3hsQ0ttK0lkTjNpQlNybEV1b1dj?=
 =?utf-8?B?aW8wNllocmRTWFlDUFFvakpldlhKZlFUTjBWdTlkQkVXQzZlR0JXclMxZyty?=
 =?utf-8?B?d0xuTGVHT0VzbXBkN1orNDMzb0RrVXpmVVlGdDIzTDRiTW5hb3dhWGEwMW9J?=
 =?utf-8?B?WVNYMEE4dTFFUHNLcUZIOEd5VllWYVpjbFNEbUprNnpuc2NIQmcyR3IyT2Zt?=
 =?utf-8?B?N2pRemhtT2hJYW5DY21sZ1lORGZZbi9TMTJ5ZGZGY0w0Ly90UHo4OHp6N090?=
 =?utf-8?B?bzVlUDIrTTNQb0hxYTg0YytQeUxndzk3TFdiS1NqS3puN04zRHhaUkNoSEdK?=
 =?utf-8?Q?cyg4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFVWVY5cnNsVnlKWERQOG9WK0ZRNzJRZUM0b3VmMGNEZFNTVm5NU0pxeWYz?=
 =?utf-8?B?bWF1MkxtVlJRNlhldDdFZEhqNFVybnNFNVQ2UE4vdXp6UnZnT2xkV1JtZG5j?=
 =?utf-8?B?NXhDdlJtTnczS01vcUZ4QlY0bU1wd1ZZaURwb1ZPQ2wvN290bSt3OXdJcU12?=
 =?utf-8?B?aGMyLy8waUlOUklnUFdqRW55eFFyc3NoRW5mamltQmVOb3NUVytEWHVaRy9H?=
 =?utf-8?B?ZFhROXNnZ3FBQ3RlK1pJNDVpWjNUMjRTdkFmSXl2aFpQSjc4WVh2a0JYajRp?=
 =?utf-8?B?V1hndmprVE1abWExMkRsRWxqUWF2RWtjVVRJbnpmdVdXU2ZmbXF6Y2ZibExv?=
 =?utf-8?B?ZlpiMExGRTAvL1g2ZUplc3VPTjlXbWpmN0RMbjFrZklNaUhDWjJxcFh6ckhl?=
 =?utf-8?B?Z204MlZsNjBtcDdqOERJVGJKSGZ2REFhLzlQTjZPaFNRZFRsTUN5OVVrK2g3?=
 =?utf-8?B?YTZkbXV4Wklya0NGSEtLOGRHZGNVaUdHejhNaDl6ZkYrekRwVnZwK3JTTi9S?=
 =?utf-8?B?VnR6YVo1T3c1QnpNVFNwY1dzTHJibEgrNWpueGNFYXFXQnZzaXROUHQxUDMz?=
 =?utf-8?B?VlQ0WU16T0E4ZDZod1lRTVRnY0hmMzU0d3BPeG9MV3J3bEV2MDBnYytxYmZy?=
 =?utf-8?B?NG1YdkE3bXNtREJINndpVmI0RkNkYWdDN0g1WVJ1Ky9SWHRWeGJYTW1laXpo?=
 =?utf-8?B?TGhpS1VlSi91UlY5bzl2Q0YxRmkwK3hoNlBGS3N1bmtXYkVtbVFIdG9vRzcz?=
 =?utf-8?B?R3pPZEJrN2wwaDNTMHZnNkJRYitQSzRKY2RNMForSnFjR0lHY1I1VE1ud1NH?=
 =?utf-8?B?dWZRYmtoWlFFQ2VBUFE2RjhQbkRRM1NidUFqem96OWIxRE43T0xKQ3JkT0Q3?=
 =?utf-8?B?K2RCdmloYzh4YmNWYUZlZmVEVjhOdHJDR3c1R0NhU25qcS9aMTVwdVMwUlZv?=
 =?utf-8?B?U3ZYd1Rrc2hqNnJlcUpYS0lLRWt3cHlRVld0ZllyVGJSeW5xUzZtQVZqendq?=
 =?utf-8?B?L2wzY2NycU9ac1FNTnEvK0RsM09vVlNDbStrakJWRXJtUmZ5WXY0RnFQT2tF?=
 =?utf-8?B?KzNvVVNVd2NvT0cvUFEzejZUVVIrSnVxL290VTQ5NVhYZnRseGNOTFgwS3ZL?=
 =?utf-8?B?UFc3dFloK1Y0Qkp2U3NpcklENS81WVRrQTRGZERUMGVEaEVRQVlXd3Nnb1JU?=
 =?utf-8?B?VGk0Q1kzajN0TnJUTjhjbDRTc3hyUXFFSEdyTjN6Z0l2WmJkVlZTdDRGUy9x?=
 =?utf-8?B?c0tCQ2xtODR5MjFKRGs2S3NKdDlRVXQvcC9HQWVkMG1jOHo2RHhPWDM4Q2Fz?=
 =?utf-8?B?Q1AydlJEL0tZRGt1ZGtBRWJjWnkvWnkvMmUvNnB1bzdVYmZ4K1gxanhESElH?=
 =?utf-8?B?eEpFc2VNRTM1aUlzTWNZdmxuOWJzSUI2Z0RpL2Y2U2NiNXhMTHZONEkzVERL?=
 =?utf-8?B?dDFUNTlnUkFHWWtTaURnRG9KV0ZJR1BZT1gzNDk1RzA3dU9FaDk3RTYybTRQ?=
 =?utf-8?B?eXZvNWFjcjBZYlVZSDBOMUJ6RHZYVGtHSEFTRWFYLytuYlZhUHdvUUI0dlJY?=
 =?utf-8?B?QVcwWkdmczlnOGtETWJIUTF6TzlERkp4YWVpZUNub2RJR1kxSGNEeFhYK20w?=
 =?utf-8?B?NU5zajlCc21OdDdRWW9wSjJtWDZnbWdCa1ZxVnUyUWM3T08xc2U0RDlWdnY2?=
 =?utf-8?B?VnUxZUVlWkF5cEFMZzZNMVhHWDkwcmYxQ1NzZTM0bGYzcjdTaEpiQmppMWI1?=
 =?utf-8?B?NFN6YXdPRGt4WWhZUUVRMWJDSUZPY09MdjBzaEowTkF4SVdZYlViKytxenl3?=
 =?utf-8?B?SE1sOFFlV0w3NkRZVWlsUmFDZ3FPS1M1K0tRRGdQKzREZEpnQW9uMkJ4Ukhr?=
 =?utf-8?B?ekVyNksyQTAzOFVRYjBKa0FlNDR0eWRvTFU3ZlRuQmhnM0htYVpmWjcxRkFJ?=
 =?utf-8?B?WThpSG9iMVI1eTd5K1VOUUttL20zZXlBU1FHZi80TnhiQ0dtWkhoNnlxSVZH?=
 =?utf-8?B?VGQ1S2JmNnU3N3A3ayt6TmxFYjlGRjBWSDVXN0RYN25vOVg0eGVkNyswcVM3?=
 =?utf-8?B?TFFvbzFRQ1BvT3ZJSFhJUytCZkt1dFRwdnM2bGFEcG5wSCtXRzRCUGlPSm5P?=
 =?utf-8?B?TnYydjBWeWtFNkxlVHVSN1lCbm5SUzRJdit3eHFGS29GMllDbXZub1R0ajBJ?=
 =?utf-8?B?Y1ZRb3N6NVRGR0d1RCtzNUxVNlI1KzZFa1phK0pOL21KRjNJVk5iRHpkV3RC?=
 =?utf-8?B?NDQ3ZE5mUHZYY1R2R1hJWHB4OGFUYzNKcVZHSnlaZXpKVHVzQzViMnlnblhV?=
 =?utf-8?B?YTBHNnFpeStqSU51NFNNV1FUVm12cTI5TWlMQWpMZ2ZPbWUycGdtQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f9dd7-f870-425e-d3f4-08de6ffa3b5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 21:02:46.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+W3+9DdmMDbzYVC2PMFiiCPn393Bm6hn9RT8iO10y8N9vrUk3AhydNejJM6ticbGsJ2lhxeBujHzvncdZfAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8095
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6190-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C32D016284C
X-Rspamd-Action: no action

On 1/20/2026 3:47 PM, Sohil Mehta wrote:

> +/*
> + * Finalize features that need to be enabled just before entering
> + * userspace. Note that this only runs on a single CPU. Use appropriate
> + * callbacks if all the CPUs need to reflect the same change.
> + */
> +static int cpu_finalize_pre_userspace(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_LASS))
> +		return 0;
> +
> +	/* Runs on all online CPUs and future CPUs that come online. */
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/lass:enable", enable_lass, NULL);
> +
> +	return 0;
> +}
> +late_initcall(cpu_finalize_pre_userspace);
> +

@Dave, Nikunj,

The current patch
	https://lore.kernel.org/lkml/1bc0b798-9cef-4dfd-af06-7674b699af1b@intel.com/

..to defer CR pinning enforcement until CPU online makes sense for the
FRED fix. Eventually, I am thinking we can defer CR pinning even further
until userspace comes up.

setup_cr_pinning(), which enables the static key, can be moved to a
late_initcall() such as above. The cpu_online() check to enforce CR
pinning would still be needed to make it play nice with CPU hotplug.

Do you see an issue with that approach?

>  /* These bits should not change their value after CPU init is finished. */
>  static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
>  					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;


