Return-Path: <linux-efi+bounces-3173-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6566A77F90
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B323A1892B60
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528720B814;
	Tue,  1 Apr 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dMBT/AoY"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EA20C01C
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743522703; cv=fail; b=g335qTDDdcPdjC4+JuCJqP2xvN6CWpmkOydv7ExP6PtBUBSEU6Y4vXHn/7aNknK0ooUmTkobFALeydLU9qRWwShV+6g1XoHyTsAjKbV4Q6J+1lRed+x4EO/AsaMUgPgwJGNXYokX3U0R4YlZjwpDwks+UFxeT5QWzeu+EsWZQuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743522703; c=relaxed/simple;
	bh=a3bHxo+LglhdRyByDQZIC3wy5aqazJys15CLZSNYnN8=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=lUgd7uI17+2UAKkRhrZYUDeFtxa7PYR6iAZVSO3kPO3ldahsSi8G3iowuQ/zp367+VAfKiC9fdrr4pyBr7mZsmHFdtAwlfjVOsrPpqPcmruRuyd7xr+4FBjnOzeqcAU7gOzz977QCcUfssbaCFlKdyPNR1xAjSXaWkEzzZu/UgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dMBT/AoY; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RubEQyUS3xfAk/iWmTXa3miptPbdRJJZDiQeE2wCHw4qheL3AY49u2naTtWR5Gw6VTJxNnpi7rbWC6dE0sWGhRYvloR40pxGk+6lw/Cq6wKPr+lgasq04Lsp1uKVI0e55gfAjAu9GGpDl662x/kZCxb8bKnfHZjBRWN/woCly3hKZEaHakzZpcMaKSqVXxt9anieCi7v3cWuXIXWLMm/HcRNWZeuFSsj4lq0+I+X0re7p9x1qnumGlDJ4cVeVLRm6QsGc+eKkGtfWDnQXp0/Xc/Ibyc/QfOBvz9R/m16lKBCnZQSr8u837+5oPhqaEUnWUnHAN2RxSxiOf/37O5LYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1KbpelJtAwkVhDTMQ0cmVjx52rFUA1yplPClOxLnh8=;
 b=KDgW87U0bE3+pabjjYQpjcUT4t0WKFaIzkT+lAA1p8HROzXtO8AcHYrfRPbQJWAMS3byNaeD8hu2QBm3aslPod5Y9fte5F/ofbKaU8rrKZz06kRs3LylM8oJezXd0DtwhYam/avsZjJBRhqsYyTlbfMUJvi+dRu1k8T+vrk4IVhUH4VzClXoNj0JgUceUWav2pC2CRiKH7VvvWzm6v9a4A+fLO7g5lbJ5ufzh6HNR2KjoAOKs1zY9WywJGaN2i9r1hk1bo5VTupZhsC1q05m+M0tg96PfiuYlkIF41cPEsQS/oYLmON2b3S5oeqS73l7Eu8XOgvIkdg+JcnY6dYSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1KbpelJtAwkVhDTMQ0cmVjx52rFUA1yplPClOxLnh8=;
 b=dMBT/AoYb3HwoT/iva/r3zJBBh4wNW6yxyOJxocM+7CwE99KaDvL2lHnkeRmvbuMDipCRPv7vOzxQAPQAlOktAK5bmNvrG4MwPUL/9TTJ6vO8+67C91b2dgMzfR+wYVrriXXSiPtAXS0PJoyGNzncXRFMnY11CdTgUkojpi8wfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 15:51:39 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 15:51:39 +0000
Message-ID: <121a6769-3b86-b1a7-1d90-524cdd82790b@amd.com>
Date: Tue, 1 Apr 2025 10:51:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
References: <20250325091614.1203411-2-ardb+git@google.com>
 <32zavhk2moqarh4vd76rnhwte45kkc3gqy3shls7mp5lemhy4k@o4gibpdf4sj6>
 <CAMj1kXHkM2hBHkfjFuCKpOA2APX+BBR-zrPfRkpiEf609UMKjw@mail.gmail.com>
 <ervuw7mwzvcyizkchy3nz4357ahz5kdfzc227exlrc5yabq4im@g2kzsrdbkdf6>
 <CAMj1kXEzzNnohJat5REp5mAUCSd4v_ft6F=P6vB95z6+f1MMfw@mail.gmail.com>
 <4xm3bmuhmdbnn6fkmhmnrtkcdiwj76dcr7gujam45nqvgupvj3@caytleltmyzj>
 <CAMj1kXFERrdioZ8_07rwDVUAoq=OLDvLCRUS6BN3GXnJoJPuAA@mail.gmail.com>
 <d6eb83a9-d1b1-7028-9cfd-1ab3fa0d6269@amd.com>
 <CAMj1kXE35QQ7b3uSF4Ufv6VXyjCfPyveUO1KLPKwsgoHu8iE=w@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] efi/libstub: Do not accept parts of memory before
 ExitBootServices()
In-Reply-To: <CAMj1kXE35QQ7b3uSF4Ufv6VXyjCfPyveUO1KLPKwsgoHu8iE=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0127.namprd05.prod.outlook.com
 (2603:10b6:803:42::44) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b6090f-6e80-4dd7-0a95-08dd713516e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akFaR1E2Zkk1ZTRUMjlGYUxpTXVPZmpTcVo1a21KRXlraE9xR05oY2YxRXpN?=
 =?utf-8?B?cHJ5c2ZRNWh1amtmK2NyRnlCSURlUG11bldyeVY3Z0dRcFlkM1BwMVRxam0y?=
 =?utf-8?B?dGNrWkd0cDZ3c2ZuL2pCcjJRb2VVNUhsTTRpVVdhNjhab0ZPZG15aVI2Ym1G?=
 =?utf-8?B?UW0zZUJIMkMzM2E1UUcyNXZsZGpuTjZVaEcxbHoyMnJZOGRkM01LbGhFQ2J1?=
 =?utf-8?B?cWZLYW5teG5CdkJ5ODhoQWVPalBQRlJRaTVZV3hIZ2tneFBKaXZMNXJpVHVv?=
 =?utf-8?B?SkhybkFMaVJSZFUyWGphUnViNDN4WkJ4L2tKQjFsUDBBRCszOUNmVjRMckwz?=
 =?utf-8?B?YnY5SGRuZnJRMCtvb0x0M0NBbk1DRDFvSGc2emxyd2MyM0hYL1Q4Q09vQzBI?=
 =?utf-8?B?dXhNT2NTbTA3RXhwN0FmL1R4ZmRFNkRvTlFrZWdmNTFNRXBuY08yNXA4ZEZi?=
 =?utf-8?B?QVQ5TENiV2lteGhpdTRyclhDcjMwcmhxODhNYTloQWkzRE11aWpsdkhDY09U?=
 =?utf-8?B?NEZ5TllMNTk3YU0zOWVRaEhBbXVWcU9PbnpKYjdWWTlBZURGUkQ3OXN0d1ZF?=
 =?utf-8?B?NDUwbVRsVWhGbUIwbkRVUDEwdlVyVjZPbUZXaWdiZjl2QlZ0ZEZlUUJGc3NR?=
 =?utf-8?B?LzkveHRnV2pPNzlRUUNjZDg5RWtUUkV1UE1Ydnh0K0FBSm9LWXhyczEyODh4?=
 =?utf-8?B?cG00K2RaVnN1YzMxaFRleGJMWGpSeDhjRlk5VzNOZU9HVzhtSWdqV25mYUNN?=
 =?utf-8?B?d0pvT2FVVXo2S0VlVDRwaGhsOVdmeDV5cnY2eStnVCtyazluSU9ucjJvN1Ry?=
 =?utf-8?B?cjBETTFoblZzeWJrZ0tIVlhWNHFtSmNLcHZmYWEwWnJ1WjdKbklJVUtOb2xJ?=
 =?utf-8?B?T0p4cWkxNUQvMEoyaGdTTEl0R3hpc3J3cVZtWklEQXoxdXlJdUNtZi90Nm93?=
 =?utf-8?B?bzJWdzVMQU9kWkppbllsMjVicldBRjBFcC9FUm9WVTZINmc5MVFzdGlPby9i?=
 =?utf-8?B?TTY2UVptNXhqNnhsNngwQVhBaXNnNTQyeXpvbk5LRzAvVDJiOVNBNDllR3JB?=
 =?utf-8?B?Ri91UHlDeWN3MnZ4bVVRMFE1Z1pnaEpMNlhqbHJ5VThXU1VVN0ZpMi8vNXJa?=
 =?utf-8?B?R1VkdS9qUjNHaWRVdmViRDBReGJqUE1GcWFKaitRWCtNRzBtZjJOSDdHeDlN?=
 =?utf-8?B?bWlWM1I5NEtOK3dtUHhBNUdzTmNJYXlwcEdTbnNLbDlHdC9reGVOYzljc2dB?=
 =?utf-8?B?VzkwWStFUnRsU3A1dGRBQ0hsSDlUZ0NMZ2JjdXAwQmsyNXU5U3c2S1AxcHNh?=
 =?utf-8?B?VTZ4dTRGakROSUYzUW5RcWFTZ3IzUmxxMFIxS0t4cW9iL1A2S2xuYStEY3M2?=
 =?utf-8?B?SkxiV1ZabzhoM05ZaGVWcS9ZK3NodTROc3pUcWp2VHA5N05CVC9hcWQ2VGJB?=
 =?utf-8?B?MTJkUEd4Zy8vb29sUCtwVWR6bjE1WFZrRUd0TExWT1ZOMDZSYW9uUCt5NmxL?=
 =?utf-8?B?ODBlSjk5QXE5UU1VNXZFQmtnOVVsREhBcTAxUVFpYjk0NSs5WlZqTGltZm5V?=
 =?utf-8?B?c0tiYUg4RFNXTFJrWStMaDByK0NSZ2p1TEU1VW9UU3lrNisxbDJMcGkvN0Mz?=
 =?utf-8?B?L1lLaVFVY01CdE95dVlYbDdzMVg5eGdGYnpLUEJHTyt1U25EVVg2Tjg1eGVO?=
 =?utf-8?B?c0I0N2dxM1JTc0RaMTVPbWpKak55WHMvVkdYVEpwQnZoZHBoS2Q0SEgyKzdU?=
 =?utf-8?B?dnUydytVZzNiSERjTXRWM2FsV1F6YmsyT3FWK1hWYTNCdWYyM0xvTWRyeVNE?=
 =?utf-8?B?M21VbkZZME56L0hMM3ZTblFmbHUrUDI3bGFiSUtueEtCd2VnRjR3L1YxRnJr?=
 =?utf-8?Q?HRnFTQXzfVnqn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUZQaGFEc0w1QjRhK1RZNnl2ektuUGhvd2dJdTYvdXE1TTlRRml3TThwaGlI?=
 =?utf-8?B?QnRwNjhXTkJiTGl6alUyR2FabnVTc1llM1FOUzlsMXQ2SmJqQmluQWhEWmZK?=
 =?utf-8?B?NWRvSUlDZ2ZhRVU5MndKMFhwRW5DMVNYeGYydmpPeEs0ZnhaZjBJTHJENlJR?=
 =?utf-8?B?dG0yeCtMUThKeVR6bEIvc2RtUDN6cnNMbkpDZ09BdHlrWFdEQU1jVWJMSm4z?=
 =?utf-8?B?QzV1M1F5Y3RwTzZYWlAyemVHcnRUaDRXY2tSYk51Y01wakdmbzBLWXpBMzJ3?=
 =?utf-8?B?VkJ1SG1OZmg1UkF5N0tIUGNWbm1HRmk0aDVTN2FWODdUK2lTYTZYVHdMVSto?=
 =?utf-8?B?eTZ6TUVHQ3lOYnJWSkdna2VmWkVESGsxOVF4ZW0ydkd3cUhjR2t6VWsvc21s?=
 =?utf-8?B?OE5wWHlNRWhHT2xYcm5NU0VoazhpR3FVYXcxQUdiTWtoK1R1WllFQkJsMEUz?=
 =?utf-8?B?QjhlYUhqS1kvTlNOY0ZKcVZXR1VmaWZqL3ZsT2tFTTdJZ2RnTnIzZ3IwMFY2?=
 =?utf-8?B?Qnp5NXJLczEyN0NGMTFUbndRVkpxZlgwOHBOdzMvVEdUSkRMSHhwNU8rcDVY?=
 =?utf-8?B?UE45QlhPdytWWEhOQlhEM3p5REZBK3F1S1FNYnZmbVFwTjQ1ckFhUjAzV2oy?=
 =?utf-8?B?Wmgvc2JxdkpTVlhoWmltYmJVN0JSbnIwYmRYekdmUzdxRmpJRi94UFdzUHU4?=
 =?utf-8?B?Y1RhbHBiR29Hak5JRGt0aWdMbCtXbGhqelMyRUt6aWc4c1cvU205alRWWHpu?=
 =?utf-8?B?OWpPV3plYjRhSjBHQ0tQbm84RVpaamlQVTVRakdHWGZ0MytuNTZEdTgzaUQy?=
 =?utf-8?B?Wnk4M1BqUGU0S01kZ2lOSUZ1ZXhMOEtLMlJhOG95WUJGc0owUGY5OVVmdU0z?=
 =?utf-8?B?cHEwQzFrU0tPbXZvVS9SZmxBM0w3SjlBUHBTQmU3Nis4Sm41YTRCTkZrVGNH?=
 =?utf-8?B?cTFBaWhQQ2RqSUluOXcyOHcyTmUyNUpYazBRTDNoR3laTStxbXR3T01BZCty?=
 =?utf-8?B?TnN0ekRtbnBCMDllYS9ZeHpCcTZraHVzNXZ5WWJZZW1aY29xSEIwOU9DSTJy?=
 =?utf-8?B?UVRiTm9PcUpvbFBuRjh2b1JZWGp5N3NnZFVBMTc5bDhKb0k0Qk1NaWQyc0hK?=
 =?utf-8?B?VjdpeE11WjJLVERIUXkyeDFqeVJ2L09zS3pXUEZRdjFQRmhmWUs0UzBOQzN0?=
 =?utf-8?B?TnhHVHZrQmRrNlRSN2JQT1E1YytuWFBnSW5WQXVIcFVnZ1YwSUVKbW9RVG4r?=
 =?utf-8?B?NTZCa0w3M2FITmpnUzFidkpDTmxRaWhEWks4M2JPVGFtTklmbWh2TnRuOG4y?=
 =?utf-8?B?dEpuenFnRUxlMFoydDU5Z1hzT21ZOW8wbEFhS0U3MHk0MGFGMk5IdUh4NVk1?=
 =?utf-8?B?ZlcvWkJzUlpTMXZqU2xZUUx2SGRWL0pXUmo2Vkw3MnJJc3VEQmFwSG1ybU5E?=
 =?utf-8?B?TlJjd3hMVGtwbGh1OWJnTVpaRTVaTGUzUjgzWjdHUmF0WmNLTDFUa0h6UG9q?=
 =?utf-8?B?Tk11RmVMWEFtWXFiQzZkQ3hVbVhBRmhOb09qUlMyLzg0UUJLbit6U0NtWnlx?=
 =?utf-8?B?M2QxZ1VrZEpLVHUxL0JvTVJsLzZFU3JXbERVeGxJcHBIY0xiVHl4TEYwRlI2?=
 =?utf-8?B?bTJZNmNWckpJVDdmeTBPVUxBMlVKTDI2MUFkSTl6SFIwcldQaHF3U0FQRnBz?=
 =?utf-8?B?SXhobi9yWG93dkxTOFBMbHRCK0NnTDUrRitjUzJVY05CV1d0MFduWlJWejNk?=
 =?utf-8?B?L0FUUnpVRWRyQzZUOUt3cjlDdi9hNEhGY2Z0Y0RiTTNiV1oyRGUwNjVLcEll?=
 =?utf-8?B?MThrK0w3cldDU0RLOXliRlYzdmVQc3p3Zkx1ZnI4cUR1Vk9hMUVwZWY4SGUy?=
 =?utf-8?B?UlF4N01tQkFoSzFFdE9jN1lPdWhkMTZiWUUrQVBSWTNNNDdPRU1wbWdMMmEx?=
 =?utf-8?B?YTlNbk5DRGpRdlVMakpId2hRRFJUMHVSTHQ0cXNrUjExMVRaaTNIeG1qZ2sx?=
 =?utf-8?B?cmhOSkNxM2VKQ2ZjNEd0TjJ6UEo0dzdhZTVBZDVHNHREZjJ1Tm9KWHJPRC9F?=
 =?utf-8?B?QUJMcll3MUFnTGVJbFI0Q080cFgyUkNiTmpyaTUyaDZ4Q3pyRVdSMnFWTGFi?=
 =?utf-8?Q?bLtJ4fsj6352bSBsM89SU5b+I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b6090f-6e80-4dd7-0a95-08dd713516e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 15:51:39.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRJmX9i1ikQZSGeW4ngflPNlQbDMOCl6xES0t/beDSA90mWAsCiJ0rS7+DReybO4dO3orSCZsGVCBWVTTOBAVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469

On 3/26/25 04:28, Ard Biesheuvel wrote:
> On Tue, 25 Mar 2025 at 17:30, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 3/25/25 09:39, Ard Biesheuvel wrote:
>>> On Tue, 25 Mar 2025 at 14:44, Kirill A. Shutemov
>>> <kirill.shutemov@linux.intel.com> wrote:
>>>>
>>>> On Tue, Mar 25, 2025 at 02:09:54PM +0100, Ard Biesheuvel wrote:
>>>>>> Since the problem happens before ExitBootServices(), can we allocate this
>>>>>> memory range with EFI API and free it back?
>>>>>>
>>>>>
>>>>> In principle, yes - we could allocate these misaligned chunks as
>>>>> EfiLoaderData, and it wouldn't even be necessary to free them, as they
>>>>> would become available to the OS automatically.
>>>>>
>>>>> But doing this in setup_e820() is tricky, because every page
>>>>> allocation modifies the EFI memory map, and we may have to restart
>>>>> from the beginning. And there is no guarantee that some asynchronous
>>>>> event in the firmware context does not attempt to allocate some pages,
>>>>> in a way that might result in another misaligned unaccepted region.
>>>>
>>>> Looking again at the code, setup_e820() (and therefore
>>>> process_unaccepted_memory()) called after efi_exit_boot_services() in
>>>> exit_boot(), so we can't use EFI API to allocate memory.
>>>>
>>>
>>> Ah yes, I misremembered that. It also means that it is fine in
>>> principle to take over the communication with the hypervisor.
>>>
>>> However, this is still tricky, because on SEV-SNP, accepting memory
>>> appears to rely on the GHCB page based communication being enabled,
>>> and this involves mapping it down to a single page so the C bit can be
>>> cleared. It would be nice if we could simply use the MSR based
>>> protocol for accepting memory.
>>
>> We can probably do something along this line since there is an existing
>> function, __page_state_change(), that performs MSR protocol PSC. If we
>> change the arch_accept_memory() calls in process_unaccepted_memory() to
>> arch_accept_memory_early() then we can differentiate between this early
>> alignment setup timeframe. The early function can also use
>> sev_get_status() instead of sev_snp_enabled().
>>
>> Let me mess around with it a bit and see what I come up with.
>>
> 
> Cheers.

This is what I came up with below. @Ard and @Kirill, let me know if it
looks ok to you and, if so, I'll submit a formal patch where we can work
on naming, etc.

> 
> So IIUC, it would be sufficient to check sev_get_status() against
> MSR_AMD64_SEV_SNP_ENABLED, and use the PSC MSR to transition each
> unaccepted page that is in the misaligned head or tail of the region
> to private.
> 
> Pardon my ignorance, but does that mean that in principle,
> sev_enable() et al could be deferred to early startup of the kernel
> proper (where the other SEV startup code lives) ?

I'm not sure if it can be. There is a bunch of code in the sev_enable()
path that I'm not sure can be moved. I'd have to look a lot closer to
determine that.

Thanks,
Tom

> 
> We have been playing whack-a-mole with PIC codegen issues there, and
> so it might make sense to consolidate that logic into a single [PIC]
> chunk of code that is somewhat isolated from the rest of the code
> (like the kernel/pi code on arm64)

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index dbba332e4a12..b115a73ca25e 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -32,19 +32,42 @@ static bool early_is_tdx_guest(void)
 	return is_tdx;
 }
 
-void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+static bool is_sev_snp_enabled(bool early)
+{
+	return early ? early_sev_snp_enabled() : sev_snp_enabled();
+}
+
+static void __arch_accept_memory(phys_addr_t start, phys_addr_t end, bool early)
 {
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest()) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
-	} else if (sev_snp_enabled()) {
-		snp_accept_memory(start, end);
+	} else if (is_sev_snp_enabled(early)) {
+		/*
+		 * Calls when memory acceptance is being setup require SNP
+		 * to use the GHCB protocol because the current pagetable
+		 * mappings can't change the early GHCB page to shared.
+		 */
+		if (early)
+			snp_accept_memory_early(start, end);
+		else
+			snp_accept_memory(start, end);
 	} else {
 		error("Cannot accept memory: unknown platform\n");
 	}
 }
 
+void arch_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	__arch_accept_memory(start, end, false);
+}
+
+void arch_accept_memory_early(phys_addr_t start, phys_addr_t end)
+{
+	__arch_accept_memory(start, end, true);
+}
+
 bool init_unaccepted_memory(void)
 {
 	guid_t guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index bb55934c1cee..162484d662f1 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -157,6 +157,12 @@ static int svsm_perform_call_protocol(struct svsm_call *call)
 	return ret;
 }
 
+/* Used before sev_enable() has been called during unaccepted memory init */
+bool early_sev_snp_enabled(void)
+{
+	return sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED;
+}
+
 bool sev_snp_enabled(void)
 {
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
@@ -164,10 +170,7 @@ bool sev_snp_enabled(void)
 
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
-	u64 val;
-
-	if (!sev_snp_enabled())
-		return;
+	u64 val, msr;
 
 	/*
 	 * If private -> shared then invalidate the page before requesting the
@@ -176,6 +179,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if (op == SNP_PAGE_STATE_SHARED)
 		pvalidate_4k_page(paddr, paddr, false);
 
+	/* Save the current GHCB MSR value */
+	msr = sev_es_rd_ghcb_msr();
+
 	/* Issue VMGEXIT to change the page state in RMP table. */
 	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
 	VMGEXIT();
@@ -185,6 +191,9 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
 
+	/* Restore the GHCB MSR value */
+	sev_es_wr_ghcb_msr(msr);
+
 	/*
 	 * Now that page state is changed in the RMP table, validate it so that it is
 	 * consistent with the RMP entry.
@@ -195,11 +204,17 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
 
 void snp_set_page_private(unsigned long paddr)
 {
+	if (!sev_snp_enabled())
+		return;
+
 	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
 }
 
 void snp_set_page_shared(unsigned long paddr)
 {
+	if (!sev_snp_enabled())
+		return;
+
 	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
 }
 
@@ -261,6 +276,11 @@ static phys_addr_t __snp_accept_memory(struct snp_psc_desc *desc,
 	return pa;
 }
 
+/*
+ * The memory acceptance support uses the boot GHCB page to perform
+ * the required page state change operation before validating the
+ * pages.
+ */
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	struct snp_psc_desc desc = {};
@@ -275,6 +295,23 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 		pa = __snp_accept_memory(&desc, pa, end);
 }
 
+/*
+ * The early version of memory acceptance is needed when being called
+ * from the EFI stub driver. The pagetable manipulation to mark the
+ * boot GHCB page as shared can't be performed at this stage, so use
+ * the GHCB page state change MSR protocol instead.
+ */
+void snp_accept_memory_early(phys_addr_t start, phys_addr_t end)
+{
+	phys_addr_t pa;
+
+	pa = start;
+	while (pa < end) {
+		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
+		pa += PAGE_SIZE;
+	}
+}
+
 void sev_es_shutdown_ghcb(void)
 {
 	if (!boot_ghcb)
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index fc725a981b09..8a135c9c043a 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -10,13 +10,17 @@
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
+bool early_sev_snp_enabled(void);
 bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+void snp_accept_memory_early(phys_addr_t start, phys_addr_t end);
 
 #else
 
+static inline bool early_sev_snp_enabled(void) { return false; }
 static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+static inline void snp_accept_memory_early(phys_addr_t start, phys_addr_t end) { }
 
 #endif
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index d96d4494070d..676aa30df52e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1233,5 +1233,6 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
 void process_unaccepted_memory(u64 start, u64 end);
 void accept_memory(phys_addr_t start, unsigned long size);
 void arch_accept_memory(phys_addr_t start, phys_addr_t end);
+void arch_accept_memory_early(phys_addr_t start, phys_addr_t end);
 
 #endif
diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index 757dbe734a47..1955eddc85f1 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -118,7 +118,7 @@ void process_unaccepted_memory(u64 start, u64 end)
 	 * immediately accepted in its entirety.
 	 */
 	if (end - start < 2 * unit_size) {
-		arch_accept_memory(start, end);
+		arch_accept_memory_early(start, end);
 		return;
 	}
 
@@ -129,13 +129,13 @@ void process_unaccepted_memory(u64 start, u64 end)
 
 	/* Immediately accept a <unit_size piece at the start: */
 	if (start & unit_mask) {
-		arch_accept_memory(start, round_up(start, unit_size));
+		arch_accept_memory_early(start, round_up(start, unit_size));
 		start = round_up(start, unit_size);
 	}
 
 	/* Immediately accept a <unit_size piece at the end: */
 	if (end & unit_mask) {
-		arch_accept_memory(round_down(end, unit_size), end);
+		arch_accept_memory_early(round_down(end, unit_size), end);
 		end = round_down(end, unit_size);
 	}
 
@@ -144,8 +144,8 @@ void process_unaccepted_memory(u64 start, u64 end)
 	 * into the bitmap.
 	 */
 	if (start < unaccepted_table->phys_base) {
-		arch_accept_memory(start,
-				   min(unaccepted_table->phys_base, end));
+		arch_accept_memory_early(start,
+					 min(unaccepted_table->phys_base, end));
 		start = unaccepted_table->phys_base;
 	}
 
@@ -165,7 +165,7 @@ void process_unaccepted_memory(u64 start, u64 end)
 			     unaccepted_table->phys_base;
 		phys_end = end + unaccepted_table->phys_base;
 
-		arch_accept_memory(phys_start, phys_end);
+		arch_accept_memory_early(phys_start, phys_end);
 		end = bitmap_size * unit_size * BITS_PER_BYTE;
 	}
 


