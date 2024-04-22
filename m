Return-Path: <linux-efi+bounces-953-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2F8ACF9B
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 16:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F901C20BFF
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D315216E;
	Mon, 22 Apr 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAJ03NmQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58889136988;
	Mon, 22 Apr 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796823; cv=fail; b=QVKQuiNRXwI9FrKkGQtcKws7wjRIk7GPm+icM1sCxGPbnlDvQtuljUwg1JmSc3vTwRvOdiaq760aYM28FEM2PFDR3P+i+ZwfwCFZJt2K2tqTczSnEH9EC6h3KGzm7ph5qE0PBw3DkoPeU3k9WojDrWzEilfJaOYr9RymoyvhmMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796823; c=relaxed/simple;
	bh=Xd1uL9OtxGvI1e2wSpeVu/GUFxZqa/OPBFA9bndgYBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JmJ8wQ9ZxffHGhUZfzAbo8cSzKe0h/s2xqGrv1tBnudSX9aHlAq8blA17N+2aRwjHry+eSTVVM7YAG1AT88Pavt6h8H+5wgP2a90MoJhMfCw9W8/laPS6tq5GjSGZrb9WVlQ00G7YMNSsrcgzHTf/NiQZ2XShLarV3JIPIMvGCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAJ03NmQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713796822; x=1745332822;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xd1uL9OtxGvI1e2wSpeVu/GUFxZqa/OPBFA9bndgYBU=;
  b=LAJ03NmQ/krzFdB6f55Rxj2ZxSiFUXiexzoVKI9rYQ2PDD0RyrtnE2+q
   RvXIwJaKsb/abxQaCakvvCouc3p5OdkQoYdWFKun3dq7dsAZzU+2f5yK1
   rPOkhqjIxZrnaCESkP/ET6yL6DFkqz0QjG2W8TVIPDetiT49O9Cu0Ahxo
   UpLCMvezHsp3IW5UXIZ4xWIMU02ssgXpadcQMgXMisoLsb48aPpO2a2zZ
   KkCy2jPQdeKp/EEzs/gPZTa1qkxAOxp8EC3TEc7Ht+LxgmN7WOImk6kbk
   IMp9PaF+1tban8qp8/g6ZX3TWLA6iaHIkPS8fzwjMd+aMZCPVoiqO8Gd4
   Q==;
X-CSE-ConnectionGUID: 6AuRIx2CSGWRZ9j2Qvb6hg==
X-CSE-MsgGUID: rGCiqZxPR5iJIY19fCrfaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9202908"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9202908"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:40:21 -0700
X-CSE-ConnectionGUID: /yssWhS3QX+oelv/o6iKiA==
X-CSE-MsgGUID: PGL8dCcJQGOeT0KQbhLsAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="47328690"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 07:40:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 07:40:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 07:40:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 07:40:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 07:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBYycMl61BTiaIG34iAAPYZmSlVZEAtetrpj/9UkvTfcYJwzZQv7iylKjPKuXJVHBRDEY49z0aewvUzfdIjVhvExx83W4I1SeT+u151DMGTyJCtZVXmmOI0fbE2yJKRV5u0Sx1UJsaD79nNGPcsBROFFQZQ5d8AiIGXyibB0hYaV7lQYmmXLO2eMRr+BeXJgGBc2ctHVWOBVBtTSgwjVCRDUmtQ/qBeOXu6BuDdgR+GNl9phcKUfBSN7GeWxLrJzNoymx37v0DcK/pFzvRp+z9q+ncexbZmVOdft/E0KV1Ds9qaprQvtEuBLn8zmTpOVmZpf0oWY1VE1cnLGyxcr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JngIC+Eyq+BR46i6QR9apHFtWrx4uUxI1O6z6/mBRTo=;
 b=gXHB3QIvik2lQYUdPUShfCd3vjRHEHg5ICge0BWVlaezL6EY0/P3U0fxduQcXfCeDMtvSyTI3Ji1RUiwDlI8C3q6faXtSp7G7UDsxIQoa2tSAlJXf6Lu3as61UbpdNIBT7RAR+ZC9iadxW2PMvjVRdV3rAOIbD99swG0RUsBLobbJ129JSOJBa9qDo5m8b6SchRc9rl0TyK3fbBEx77lcAq0j4IZ2PnmzAN1NbViOBDRFwFYnYj9dowi78i/sTE7i0LUtXgdttC+4cegMo1wPDF5HOkKljtntC/qEAYQR38MADFZFQwRPM39WX1dY8BKOxIrqGJoYtxGk3TCaQeOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 14:40:17 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::5c31:7f0b:58b:a13f%4]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 14:40:17 +0000
Date: Mon, 22 Apr 2024 22:40:09 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: <linux-efi@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka
	<vbabka@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, Chao Gao
	<chao.gao@intel.com>, <linux-kernel@vger.kernel.org>, "Hossain, Md Iqbal"
	<md.iqbal.hossain@intel.com>
Subject: Re: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
Message-ID: <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
References: <20240411004907.649394-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240411004907.649394-1-yu.c.chen@intel.com>
X-ClientProxiedBy: OS3P286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cea8e25-a372-4c60-b2b0-08dc62da20eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K7wqxB2WgdVEuu/urXUd1flnL2hN/CbAWT/YDkpe/yHL2kNIlp29pa9x2GVV?=
 =?us-ascii?Q?3eItwwhhZWQbxrHbU0N8wbFQ08OvvkmHoSkwDZRZjJjBW8NqFAbH5wpN9o6d?=
 =?us-ascii?Q?V5agZq6rSWE/K7qz/qHim8DrEW3Rgovnx0x4DcKJ2HIhg6oDrW9gY2eNvgcl?=
 =?us-ascii?Q?cuXH0zjHif7uTV1eCMOO+iKJV33Y+WTj7kRbDuaxvHVQwe2Boknf5CGShGsr?=
 =?us-ascii?Q?zED7/Xv2FeRL057V+uT/AMXXRqgW9tNB1Q4kaAQKk1pjXXobUdQsZ0Je2S8e?=
 =?us-ascii?Q?OBs7g0gYH43p9TVR12GEBMZtiIKedcwu5kGFDaQqDTc4gRk1yzoAf9Y+lf2w?=
 =?us-ascii?Q?sHgokFvdQIDLJrwnQ6y8+s/6fgzbDGtPfBVzmWjcPxGxUKCV9vYFuwOYTlTy?=
 =?us-ascii?Q?Lvj2WtKRx30upfIpxHhY93srWmA9MhS3XMTc+aFnM2S4DnGesB6x3k7RnkRb?=
 =?us-ascii?Q?CdMM37GcSJmyjWnGM9hHwwQGEQy36MucbBQoKGA7s+loXgBlHc03mMNdS4+m?=
 =?us-ascii?Q?kABMevB8tNu9NpLWdRZ397o5w7uxPvXmY8Y9140pcyIWCrK4ZncO45bFbHOZ?=
 =?us-ascii?Q?H68V8rUssne+E3inA4coi8sNrzTaEIKqVMmWcVd0xuHwgw7ZPKc1OTcYFWWs?=
 =?us-ascii?Q?9JX05QjFki42A5xzWS+RZ+rbYxZL1faPwvmoXkAAzWMPWfSgRLZnORDme3f6?=
 =?us-ascii?Q?bXyEvKR9rNEPZ3JRnRH8kK1eG0wW3lSGfyUgu/XOGcvdNvAP2RJA2HnvreU3?=
 =?us-ascii?Q?HbtVbsF27Tw4hWxFFyWLvJPUXDoMQc9K0Umnq2bUt6mhgl8XOmIOs77+XHQR?=
 =?us-ascii?Q?Q2ESIgz1+jnZ1O+wDq8iF2HkqYmihvGKvQGcq+pmaZKak0cgPmiTpQieEjis?=
 =?us-ascii?Q?Ym+uPIS3mMOOosKJABIT0mvEgh24NPrR10UixzCup09CuU4XfulmQ/Zxja+g?=
 =?us-ascii?Q?46dZtFO+drURC6owh1GCQvIZt+nrZ3mOvw0gDf7Xd/EzaUysB/NvWhoOuHYO?=
 =?us-ascii?Q?8/0KSkwqOq6xPlv6niY3xjvlnJitMmRkls45qEMmn0sGL/XktGDYE3sOIzH7?=
 =?us-ascii?Q?AHgUnM93yR74Bz/bUonM+x5f377qn+AyohxtbvG23f47JCsBADc4KIQHu7e5?=
 =?us-ascii?Q?mrqCtE9gpvMRCVQSEeNRU77auskG3rdHLLcSpY8Lt363ESSXrf6HOhL2opxJ?=
 =?us-ascii?Q?UPcjlY6zWNiUsKC8UxHvRkknXR2Dut2SKXUtODeumLWHWXFxF+vBbbb2SvHt?=
 =?us-ascii?Q?1HlTOvYe1bkYRTQQBVquaov0i1x20S3RhhIIc90uOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BArDM34FhwTE8zMOlqVoWtkVw2OJsJm5A/F+tPF3mn3qDComL2R5h9IKbPv8?=
 =?us-ascii?Q?rIJZCLZ2bhzUPJ+hQ6ioG6gwvEJ4JAwafT5ggovR4H8wOlvTZmpgOHiJIKOj?=
 =?us-ascii?Q?88x21XYFsrnnvTSec2fDEi+BuQaRPQxhkCzvxxuuZbfDLitXcK/QDJS+Fjui?=
 =?us-ascii?Q?ZAc0bikjdlITx8YTxWhWy+r4lerlUsacKya30Pt1XfZ6aDoVl14PRoWfkR1G?=
 =?us-ascii?Q?cSQfeFzJWkfnXSmbyKuSK8ng1Y01OyAQ2ne9dJNAbktL0R2QNTehCoQx2N29?=
 =?us-ascii?Q?dIkrDLKBhAp7kTbVkiWAFLYx954FwErAKs4QsO0TA9z+1o4HW5AUOfwmBQAn?=
 =?us-ascii?Q?lPLZwA2KCkBH7Ysj/rwT82ZkjlsDhwm6KbkSYFFtNZbRkHDuHte0UsAmXPWh?=
 =?us-ascii?Q?dzToDBR3TAUa9a0JghQF1Qhmh3DRo71pAIOHscvAPc5mhnbvpKlACATcmlh6?=
 =?us-ascii?Q?zz+XZIen5E3/DOYcRHWCRFrr1ZICiTDVuRgJP1UmWtX04uqq9F8aeTkUZDaj?=
 =?us-ascii?Q?dgcYEOd9H3CAJSDohiMDa3vCyfyCfRqfXcfb6rmnrHYzUXqGlP/2CWeSXyG8?=
 =?us-ascii?Q?YwB1Qk3eTQcIj7e+yNS2MEcXhV7M+Up2U0BeGyDfATvkeAcyCQspXg0o7sek?=
 =?us-ascii?Q?isXDaRRrJw2eG6far6RkFzdG3lsYFzMv54OsSA2FIywQsBPAlIplCTltKfZI?=
 =?us-ascii?Q?0mtLtuNID21LKIT1EohLv//O7RLCpJdWKA6/LAqovkuG+B42sqrnAJpoSKvJ?=
 =?us-ascii?Q?qO3cKWHCyK+7SfXq4eUeEnZ1JO20HwzVZMCkbGvpC1kLFfpJc/hl5tGW9TxX?=
 =?us-ascii?Q?U2Cq5+SMio5kI7hU0uJQIE7XkfT9ZqhK3nqI4O6HcErVYONhH+kLeZ8R0F1M?=
 =?us-ascii?Q?T+UBIsdk0A+Daz88JNjguU/q4eTEKPruTSmBSePQqPHUpKdpQLmBkN9EIED2?=
 =?us-ascii?Q?cFlMffqrGkLUasuRGfQnacuat14mqmXBPisE9/Q1cbAVzCrfU6UoFNfrx0cM?=
 =?us-ascii?Q?elz5YDSYn4iivFLBquqX0rjajSKAil1+HLElCO8urzypxnjLdmh8yB/mFFc3?=
 =?us-ascii?Q?SHWHs8Ckwo0LnOGwo7nev04fekuoVkKT2TlrDCOjbjwCoSd6jdZfkSs9wLH3?=
 =?us-ascii?Q?NEwKpvhfmtRtiDU+8NnfQ3ZHs+98pn9ntrMDy44UVkJH/KWHDxTx/5pFlxsd?=
 =?us-ascii?Q?NNVPvFBQrZYva1fGIsF8Uue7WNCRNLxW3idCATgJ2NVY6QzMoIRATzz2sBxF?=
 =?us-ascii?Q?Jj20XSzsUIOXlxqQ2F1J/wuQEZ+jbLxXbUrNfeJfyXw/akahdFi76IhPi7pr?=
 =?us-ascii?Q?CdwB7/M4jA/F+Pd595Lbd8XHFR+TiK5V/6E/FIhpFuu0D1JxRVQ+eHoy8/zc?=
 =?us-ascii?Q?+N+PA2X0iyaW92waPLXtQCoqZk2vos4BybFekIMe7f6375RuG7obQHVc/P4k?=
 =?us-ascii?Q?QykmQURE/yMFVwpxkt4wJ3toi+IdgQzwXxQcSAkMPbwTl+vFeMjDAFW1hbb7?=
 =?us-ascii?Q?sa+Q5FqOQKVvv1HaBXNkK3HrZ47wFuH1m8NdjG59llGVM+Rcc9D0g7shqiHs?=
 =?us-ascii?Q?ro+7Cf4qjgm93nKIbwtv9Bx7ck/uRCQLy3bmF8Kc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cea8e25-a372-4c60-b2b0-08dc62da20eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:17.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PApqeY/AtjEXswrC1n4O1qP6mpua82lCqVESZzdNtrpp2khBNPv/h0+ZKhsfSuumUQG0/Pg99wiASu+2q+y8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

On 2024-04-11 at 08:49:07 +0800, Chen Yu wrote:
> Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> by parallel memory acceptance") has released the spinlock so
> other CPUs can do memory acceptance in parallel and not
> triggers softlockup on other CPUs.
> 
> However the softlock up was intermittent shown up if the memory
> of the TD guest is large, and the timeout of softlockup is set
> to 1 second.
> 
> The symptom is:
> When the local irq is enabled at the end of accept_memory(),
> the softlockup detects that the watchdog on single CPU has
> not been fed for a while. That is to say, even other CPUs
> will not be blocked by spinlock, the current CPU might be
> stunk with local irq disabled for a while, which hurts not
> only nmi watchdog but also softlockup.
> 
> Chao Gao pointed out that the memory accept could be time
> costly and there was similar report before. Thus to avoid
> any softlocup detection during this stage, give the
> softlockup a flag to skip the timeout check at the end of
> accept_memory(), by invoking touch_softlockup_watchdog().
> 
> Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v1 -> v2:
> 	 Refine the commit log and add fixes tag/reviewed-by tag from Kirill.

Gently pinging about this patch.

thanks,
Chenyu 

