Return-Path: <linux-efi+bounces-3333-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF0A88C7E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D66F165E3A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Apr 2025 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DCB1C8601;
	Mon, 14 Apr 2025 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jBGZzUDC"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3A1C6FFA;
	Mon, 14 Apr 2025 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660424; cv=fail; b=qgQKEzb5v+VRx2ITW7s3/VCkhU8uUApNYXZzozMFosumMqZGOKHwwi3bnEX36+TE8k/t6BhJxM/4iGgq0o+LMaPpBlQ++EUSjB91D2GmjtA9LWl1hqqXBp9GmuW1Giufd2aUCd5nDQ540IiA7X+OYkgaohKAZYyVDaXS04L0nR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660424; c=relaxed/simple;
	bh=2wJseyXBCsVxYCgH9/dWQJvmG3vm20TLR6L/dQqnsZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gzuy07W4odwwEMFfvzXj4UXriwrlLVuCJ3WQdpEGvUF7bVkq16nrdChscQErCobhzg7eXiKX3SCblTs/mvVuNXIJ9y594sCP9wypvTI63PxXhvo2sNjz1DYYwV4ijQATO4ToCkICAnvhUnjVf6oo7cQUxm8tuBJCdEiexDQFtYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jBGZzUDC; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7yK489v7WLUhqDs3w4D5Nyu9Jx0AK2F6H9a38ZH/4+vPeNQbffJfQBuAhTciW6FN2EFz13eO6CeI7SjMU7v1S5GbcRRSWki2jEGV7xwbaIIH9C/kiPHSCp5gp5GMysfwFMljfQiBd7DrLDEFVB1/el06kniXarDBUqH7667jJPLRa41k+ZuHbGdUcUR/2t8rboCe54cxTVD0N3WNfacxo89xZzWrl+jk7aRrqgDDGjYklT2Fo2Ov29WbwKpyqEHLdszTgb8D6WndZzkcPbn07gXfganGy0pZ8DdNy6pPu3AQoEtjPNgEkNfPX0a05s2cZ43uJLfLXW36Lqm0qqr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brq3EiBvr8WRGUoTODnQFaAE+zNTmXVVeXTMxQ1IjUQ=;
 b=H5YgaKF72I6rVgiAzMDCRTWcvbzu/aq96tgD/Dl3q4flMek6kWEVkd3K/Lg4CiMgdwWJ8N/mPBYmVRD5kro/pVr+C/RjOBnWcTnRUeSeWzV3HLS4rIhEx5GrdSyGfKXj05/U/A68hR1DHvMzce3BGr7voLsnBZc+MTWrdCAqlxM5xr4SJWGYydDBDKdRQCgZp4Jv5j8EJHRGEKa4yR/mdf+THWE4DoJ9KVob6uWOEH7MitWbiByEIYadHkWMDD4AbTp5PoPN4Xtz3A8DGefuwKrYxByo/o3JgUn3mQJmLw4HDMtEglx5yRB00it2H94K+o7c/uP2N9zFzwCZ7O6KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brq3EiBvr8WRGUoTODnQFaAE+zNTmXVVeXTMxQ1IjUQ=;
 b=jBGZzUDC/xTkXNVBQxBTGnkH3hf7XswIBc9EwYYDzLSTZm5Lm6Ramqk09zGsoeu+Fj//wR45TNCeXe6HFEziYZvSONXyTFcZzsoeTSxSfVHUfKKP8b4oEQryCsrH+0+ZXXeyvFg/sLGTo4Sm2Wu7SIwSEV5JFwYXVq0YqXASiWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 19:53:38 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 19:53:38 +0000
Message-ID: <ba23ff1e-b9ba-3633-7712-0a73f38a0fe5@amd.com>
Date: Mon, 14 Apr 2025 14:53:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC/RFT PATCH] x86/efistub: Don't bother enabling SEV in the EFI
 stub
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250414130417.1486395-2-ardb+git@google.com>
 <e48bf1ad-3d48-0867-35ce-068da901d01c@amd.com>
 <CAMj1kXGOegcJhOOiyw_0A0Y1GW0K3LqBuhpn1TrVp4aKLGn=-w@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGOegcJhOOiyw_0A0Y1GW0K3LqBuhpn1TrVp4aKLGn=-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0036.prod.exchangelabs.com (2603:10b6:805:b6::49)
 To DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: e5db73a1-6f77-4836-ba84-08dd7b8e0c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFVHVkxSL3o3U2VHcDFKQ0lCNC8wQnNuL01wa2sza0k5bFlrSFpDMFZLOHRJ?=
 =?utf-8?B?N05wcDhBeHpGVVZsN2ZnZlcwdmJyQ2xHOFRVV29hT2o3SU1kMllKSldqN3dE?=
 =?utf-8?B?YVpnOWtXb1lZb0s3Zmc0S04zZzFIU01URmpva2E5MTVrczlrK29peUZFdG0z?=
 =?utf-8?B?MS9jYnBiQ2x1RktQRW43VnNaaGR4Sko2ZXVDb1FNZ2l1cXk4ZlBOVWdOb3RX?=
 =?utf-8?B?amtxQXl3Vml5bzBhUmp1bVlKYzBFQldkcFp0citLOFNsTVhrMFA5ZzhGbkMx?=
 =?utf-8?B?T0RRdjU5UXM2R1E0QUFrN2dhYU1KQWRqYURiY1doYlgzREhpbG9HTG96MXV3?=
 =?utf-8?B?VDB6MmRuM2ZZckw3VXRzc3ZoWlFleGp4Q1QvSDRybm00bHpmTjRWcy9VVFRS?=
 =?utf-8?B?NmJuakhhdnl2N29TYm5GL2ZvUGY1VkEyWnZlUkRaNzMvQnFPMWxIRkUreExn?=
 =?utf-8?B?L1lMWUR3a1cyYitIUzRWUHpreXNrTEtacGFQRWFLZWc5dWUrd0tzeFZyNGtP?=
 =?utf-8?B?NU9Zdm5hY3Jodi82OUlkR1NYa0hCbi9oUnQ3N3poMTduNHB4dGZURFowOTY2?=
 =?utf-8?B?ZGxaK2dUMVRpaDJDK3NkUjhvUE1WQ3Q4Z1Y4dmRhd1hPZ1Z6OCtkWElja3c0?=
 =?utf-8?B?STBXc3lzTzMyUDdLakJEL2pBVlZuWDdMS08vSFVOVzFiUUZnY0N3ZzdXbitz?=
 =?utf-8?B?K3FQeGRtb2hzU0paY1JLUDZ6Q1lOYnJCYnhOc29OMEl2ZCtha1JkaFkwdWc2?=
 =?utf-8?B?MlVGcE9MOUVmSURwU1B1M0s2QkcwQ3NxWHluRFNOaSsybjNJSXYwa2dpajRr?=
 =?utf-8?B?ZmptYmZWc3NtbndpWXlWUVZ5T21Sb0tRWDROWHZFZmZtRXNJY3MydUx1NHFv?=
 =?utf-8?B?Skl1MnFIMEx3aTJOTGk2L2dqbmJmRGJKM2o0eVRWZEcrWlRmTmNyZmx6OHZ6?=
 =?utf-8?B?R2prVTZmcE10R1VMTlNhV3ZpUGcxanpCQ2NaTXNmYlhINXJpMWduT3hZZklZ?=
 =?utf-8?B?RDBPQWR5MWhKUXpTZVpteXZ4R09TRkJ4TkVGR1lFZWkzd2FrMk9takZMZWpt?=
 =?utf-8?B?VGZWRXNrYnM3elFWTWV5VFhqaHVNRGpPMVY2czgxNGlMS3QyL1g5dktrbkNF?=
 =?utf-8?B?NXM3SjQ5dUUzQTJaREdzZFd5NTVYcDZCbk8wMVhrZHdLNVBtOTN1MVRDUUh6?=
 =?utf-8?B?UzNVb2hTMUk3UUxGYnRiT1h2TnFZTFRoUXZDNlgyYU5mTVVwdnV3WDZrSEdr?=
 =?utf-8?B?U3RhVXB1REVRdCtWNlpmRkU0ZzZpdmY0SzFTMEtoUFhVa05qaEtDcG5PWlNN?=
 =?utf-8?B?Rys0VHBFOVBiV28wYzZJNjVTL3dqRE91ZmVRZkx3QU9yWVUvSWtUbk1qelVV?=
 =?utf-8?B?N3RJYXprNURZWDVTM3RocXZKazg0bnNmUXlUeENsS25pTWliWjQrV3lLSWdS?=
 =?utf-8?B?NEdZakxQTDE4TGVla2NtYVpKWGR2Z0Y2dUh0eW9kdnpweHdkYXBROVhXRGhq?=
 =?utf-8?B?Q0g2ZjY4ek4vazF3b0huZ25GVENzM3UwRisrcXAzQlB3R1BrZHZiWDZlK3BU?=
 =?utf-8?B?VkdscXRiYjhTSHhWV0xjaVM3RjRQeUgwZmhqakRhcjh3ZnUzU0JUSmNBK2gr?=
 =?utf-8?B?clNwU1I0cVJ0OTh2RlBkWFJndUYyeEZWQU9jNUNSaDROOHVCcFFmYzBmaXF5?=
 =?utf-8?B?Q09LdzRPM0xhZ2Q3VXAvcGRnbklXcjZ3NzJ1NGx5cXkwNUsvTndoWkd6M1pU?=
 =?utf-8?B?cERHTFVJdW85b2pWSTRmZkc2ZnM2akEvVTBIQmVaZmNxUEo0Y0hYSCsyOE5J?=
 =?utf-8?B?V0RNOW42dU9rcWxDSDRvSVVIZnVpbGl5ay9FSTk5cTlZTVN5SFhwQTBXT3pE?=
 =?utf-8?B?aHV4S3ZJYUt0TWxTZnowelQ5NFRHOXB2RHUxYjA1aE5vRTNwdE9oZ0VzWlEz?=
 =?utf-8?Q?HlS3t0LXReI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDc0aiswRjhpazJMZVFyNTAxcWw3NUxueDNWZ2tERVJxS2JHUGFnbnVielJB?=
 =?utf-8?B?UCtIb3pUeUY4ODhwcWp4UHRVZDI2WHRuU0JHaE5YdGFhUFUrT0xVOWxudGd6?=
 =?utf-8?B?ZmMzZklEYzNwNThTS2xBbzNZcVBHYWdhdmtGUzVBZ2wxbFlFdDRUaitEZ0dE?=
 =?utf-8?B?QUhGdG01Yi9hdUVleS9ZdWJ0Z1hVUTNGbEJ5QkxaalIwdmxNZHpwaUkrRWlK?=
 =?utf-8?B?MlljMVQ2cXg1dldRTTJJWCtPMkgrOVc1OWR2cTQzS3U2QUxSeHRpMnJJU2hC?=
 =?utf-8?B?emF2TjVlMGlXaCtOd0hjem1BcTBDL2xsWTAzVlZndTRRM0gyZk5vdklYN0VR?=
 =?utf-8?B?aGFtYmJ1ajdvYU90UnRYRnAyWWlic3J3QUs1RUc5M2g1clppSVRldnFYSkNK?=
 =?utf-8?B?QkdCbUNVZ2drSEtUcm5xRFIxNXZ4a2tCT1VTc0ZJSWwzZ0MveDM3TVpDZlJs?=
 =?utf-8?B?c25ZVnFNNTRkTzJiNTFuTWxtWDJmM0w0cWlvbUxLZkFYaVVmOGlza1RHRFhD?=
 =?utf-8?B?eVh1UmdIZWczTDk2VFJva0d0N3M1eExMVnNkV0gwdCtpaGdzQXpTNTYzaUJO?=
 =?utf-8?B?Y2hFWUR2dUtRTDZFdTdVdENiV2RzUHVCRG8xS2hWbGFJU3dsZWt4Tmp6Z3p0?=
 =?utf-8?B?b0JSK3Fla1ZWeEdXTzdCZytDNlZ4Um11Y0tBbGxWcHVUSzl5V2YvU3ArSk1s?=
 =?utf-8?B?WUNNOGVaa0RBWmxERE1oSGQwWXFFQzlKKzJOL254aEE4NDFmNUZoQjRBNVVV?=
 =?utf-8?B?bGo1Rm9uclJEZEdNcTBnd0h6SFp1SnNETkpvcGI1eElxYzM4MXZXQVI3R3E5?=
 =?utf-8?B?dWVCUGNRRGNUZGdvcGEzMERlcy8zRW1xSEptbWQxbTRSaGhRNlora0c3NTVM?=
 =?utf-8?B?R2ZGK1Evak1mcTJETUVXT2JJVU42ZzZLY1FrQTFKY2JUKzA0cmRLR0dpM1FI?=
 =?utf-8?B?ZmpXcldKdWI1NFZLWFJTa29BUi9SLzFtK1cycGRsa2RSWTRLUy9KUVRiM0Jq?=
 =?utf-8?B?ZzJvUUVoYU45bGdYaWtlNEpqQjRpTEdQbFFnZFRxNjd0Tml6V3Z3MG4zU2ZV?=
 =?utf-8?B?VFFRZEJVbm8rZVlIK2hjbE85eGxUWmwwM3FUcUVPYU5DSXl6MUJjNWJoZVpy?=
 =?utf-8?B?TmlWNWk1QUZES1JEMVRaTHRsaGlaZU5mWUVRajdPaWhhc2VESnI1SkZ0Tkww?=
 =?utf-8?B?U2ZwSXp4MnRuUGV0M0ZmQktEMGpWTlQxNFpVVlVhS3AzWThtODFCV2tDSlZt?=
 =?utf-8?B?WlMwTFZ0YnovdHBNdkJvZGtiaUtUWWZ2K0pkYTdLTVdPaGlIS3hCS1JIUUhT?=
 =?utf-8?B?RHpiTkNuQmRWRlBCbU5NdEtRc2pvOFRRalFWMGR4TnRkUkRRRGl1Qmk1NHh3?=
 =?utf-8?B?dXYxUmhuN3FjaEs2RVZ6OHU5YXFRM04wWlpHdWVkUnFRaVdseW1FSGZyMVJx?=
 =?utf-8?B?Y09hWXJQTi9XYkR1VCtFejJhQ04vTnNBL1hPdm0xems3akw5VHc4SzFlajFk?=
 =?utf-8?B?V1d0WDQ2M2Rkb0ZlbldsMFlIM0VmL3creTZyeTNpZDJSSlpRU3FQd3l0clhK?=
 =?utf-8?B?aitTb0QwZXdIdVI0YTdxL2s2bnZxM1phaGhlTjJUa2tITmZiam5jK0JSS2Vj?=
 =?utf-8?B?NGlLRmY1NldZZElqeVNVaVZ0cmJJam1yMGNQSWYwLzdIeEdhbWJiVDBDUXFy?=
 =?utf-8?B?ZWtIelZJMlc3cXdrUXZ5L1c4dWtORDQ2SDZyY1ZwVTVnRzJ4VGhvQ25DN3k0?=
 =?utf-8?B?MlpiN3A3WU5SUmpVckhVZ1luMlZEUy8rcG5HclM1MWwzZ3gydFp3RTFRWXNk?=
 =?utf-8?B?UFJuS21oZVVRanJTbXN1V3c3akNtNHBBVEtoK3IxMUJxckNPYnQ4ME52N05O?=
 =?utf-8?B?a3R2ckIydTRlczFwMzU4anNQYVgzem93dWJFcEY1T2xVWi9FMkdVVktHTDZa?=
 =?utf-8?B?NjY4dnh3VWoxRU50VExYdjBKNGxyTlFPZlUySGw0aDd2eFBBQ1A1djZQNkR3?=
 =?utf-8?B?bDJUNHprQVhSU1p5NU1MdTVPRHp3U1gwQ1NiaHFzem45YmhQekxLcitmazlt?=
 =?utf-8?B?MXdNS3FteUJQeW5McFpOb25HM3EzdFA3bHowSDJsOW1hY2lJZWoydEU3Tmhs?=
 =?utf-8?Q?5i+3O0EcxnDgMcfupobzpH88B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5db73a1-6f77-4836-ba84-08dd7b8e0c14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:53:37.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NY2pB9TtekZpIqZoRr8L/QeC/81XzuuuhRNOI0G6UNA5OYzk2DrIuaB9IobG3w09dRSbhXWmd+btjhIeT5gBrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

On 4/14/25 14:45, Ard Biesheuvel wrote:
> Hi Tom,
> 
> Thanks for taking a look.
> 
> 
> On Mon, 14 Apr 2025 at 21:10, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 4/14/25 08:04, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> One of the last things the EFI stub does before handing over to the core
>>> kernel when booting as a SEV guest is enabling SEV, even though this is
>>> mostly redundant: one of the first things the core kernel does is
>>> calling sme_enable(), after setting up the early GDT and IDT but before
>>> even setting up the kernel page tables.
>>>
>>> So let's just drop this call to sev_enable(), and rely on the core
>>> kernel to initiaize SEV correctly.
>>
>> SEV support does some things in sev_enable() that aren't done later in
>> the kernel proper. For example, we check certain hypervisor features and
>> save the CC blob into the boot parameters.
> 
> I misread the last part: the kernel proper checks struct boot_params
> and setup_data, whereas the decompressor checks both of those as well
> as the EFI config table.
> 
> It would make sense for the EFI stub to populate the field in struct
> boot_params directly.
> 
>> And as I look closer, I see
>> that we don't call initialize_identity_maps() from the EFI stub so we
>> aren't calling snp_check_features() from the EFI stub, which we should
>> have been doing.
>>
> 
> The EFI stub has its own check for this, based on the same underlying
> logic (have_unsupported_snp_features()). But it checks this much
> earlier so it can fail gracefully and return to the firmware, rather
> than terminate.

Ah, whew! I forgot we have a slightly different call for that in the EFI
stub, thanks for reminding me.

Thanks,
Tom

> 
>> Just removing the call does cause an SNP boot to crash. My testing shows
>> just ensuring that the cc_blob_address in the boot_params structure is
>> set results in a successful boot under SNP. So some of sev_enable()
>> needs to remain and some things need to be moved into the kernel proper.
>>
> 
> Thanks, this is very helpful. I'll dig a bit deeper and try to address
> the points you raised.

