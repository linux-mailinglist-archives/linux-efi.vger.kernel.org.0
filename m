Return-Path: <linux-efi+bounces-3089-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC1A7079E
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 18:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7C1689C5
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DAB2036ED;
	Tue, 25 Mar 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PUZX7SEA"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2F1A23B0
	for <linux-efi@vger.kernel.org>; Tue, 25 Mar 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922212; cv=fail; b=DtWUPBH8ipfRDiIEC+pqJ4UnCB/DnXd1tMv/yeWyGm1vfqDYAHgKRVuUrWz433mHc+jKQ6LF32FsIUx35ZmqZng2I+Hvx3mX5wHDdIZlLfnvJaXMfGe4kcyOOx8vOjBpJu7lCtSQ9Q+7QTEaexxAz8tkSzwi/qt/t1W8cM3FEFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922212; c=relaxed/simple;
	bh=ECwsDtfj77K805Fko8/CwcBvXjj3+VG2yn4bc4y6yiw=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=LWOo8tkjsjiE7tVnva++KwdkscJlO3JfjI4myWFJwzva/oqhXjeLafl6aobu19NdAvJ+9QTnbTbI8kcFSVofELDsrxId7hCp/OAdeWCeqrOletJgVKXpCxIq6QwTgxfTXPNbtaaAIgnJXp9SUqm37n14d1KaPRnY+a8/e3dPCBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PUZX7SEA; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObY7/ofEUJgAJCLTOcVZ6I4unjj+9ME4Urng+2yyHFrLWFQskCkT4s0qLFyHtHlZeyaEshOPNUCLshOYv8TxfIHd3fTfaF4HGJ51ycySWOFar/WOqR9NVEiRolutWy6XHnHFAEgU/bbW8NUaJ5gcqscTjGIObN6YTSEO6BiOrwVLNYd1ikJpsSQ2HgdgPEM46sdxc3adDFDEF/tqlOiBepnXF28oHhseQK+dd8ES0w4BHrVNoJtAQbB+orCS0+lfwuy98d1nnxfBq4yQBxGIsC4cfhp9LGSvz4T29aOr94IgZMP43Hi9X5ZX47s5+JvaXc5zmd9k54gFElb2C5epvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYYt3SwPK+JhwZj6yabKz+HPyeqc9JnZt28S+VZBxj8=;
 b=FEl7y8VVtRODIdh1pVxoMxRofks2qgJuz+MbSLZVD5PMPWXSBk1vxcK7Fj6Ndw64okVUucUZEJEJvaFeF18MiydwnAQwqJFK1xerA1rkbZ33C+I0Dmuggy5IgTK0H9Moh4UW/9eaQ94Ur88LX7GPI2x119hRLxelVNs+mOeRCgDkLCNIyizAfc/f0zb+akLiToNr1LgWIS41kFDu/r4kmj3dKWnKmzVTVS115gX34pFebOeaVzsKbyW3/ItphsmsGCp+meRVuctDpwEa6JEw4RCIiLBKWBRIdUny2rLlKwBSjfEBuQDByIHBFvG4j3bHNnf7pe/Ykh6ictMCtAKEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYYt3SwPK+JhwZj6yabKz+HPyeqc9JnZt28S+VZBxj8=;
 b=PUZX7SEAFbc78xRsnfoOlCETds1uGWyOtxSBDc+36mVsQHm1p3M4UvEyGAJE32fVZWBDkNVttrmCMz8iaZKtOcFmyl/J/Xgwp8xC3JSYjdXBQpVp6o3sdUuxtUDGvRuBbK107j0JdXqE/TEc2lKKDNE30vE/IwJ6QGvy0OjbPa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:03:28 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 17:03:28 +0000
Message-ID: <8c466989-9775-adc9-2091-3e1aad6d7436@amd.com>
Date: Tue, 25 Mar 2025 12:03:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, linux-coco@lists.linux.dev,
 Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <CAMj1kXHacRusnpmGJecMU3L2CCyQtopBL6KqoSVuF7tDW85TUg@mail.gmail.com>
 <874299e9-eb4f-7775-4ea4-69d449ca1e05@amd.com>
 <CAMj1kXGu-2KNKLwYvRYRv7sd3d2XR8Q0wDOdRK84FYXOirO54g@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: query regarding SEV logic in early boot
In-Reply-To: <CAMj1kXGu-2KNKLwYvRYRv7sd3d2XR8Q0wDOdRK84FYXOirO54g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:f2::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: a6946fea-8940-4bcb-b8c6-08dd6bbef682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGtZM2gwRG94d0laa3F3czJDNnZ2NGs3bEY2cVFad21LMUJORk83QkNqS1Fk?=
 =?utf-8?B?YkdmbjNLclFRSFlGandJY0JHR3prcTk0Z09SNHloTjZDTjJ5dlg1aEVNRE5X?=
 =?utf-8?B?YzdSa3NmNjJNNURodUlxa2IyWW4xM2FMcGJaMXM5K1V0RG9ad3d6TGpnbXpQ?=
 =?utf-8?B?amFDWGRkdUlDcDM5RFZxMDllMWJYU0o3eGlhaTUrZWZCSndwd0VneXB5b3Bu?=
 =?utf-8?B?S2lLRVBYRnlqTS81N0M3SkZLTzdKUGh4UXZIb0dvOTBnOUVkRlhIQkYzMCt2?=
 =?utf-8?B?NVFObW90a2FjeUV6eUFpSXJXWmpkREw0bVlmc1ozb2Jac0JtbFAvUjJkZm1i?=
 =?utf-8?B?MGU1RGw3TGdUZVYxWlJGZzB2amxqWXVxU3FzdHBGeTZZM3JnL1M3MFNCUW1G?=
 =?utf-8?B?QmxFZG5JdStETmE5bGx6WklXYmFaWFJOUEFHeEl2eDZMK1FEWU9QcmJFZ1k2?=
 =?utf-8?B?d2g2UjVzWHRTVDhhQUIybkNZZks3NDI0RUVxd1dnaEFYa09EbVpIMlFDZm0x?=
 =?utf-8?B?QU15cHpWUjYycUNvUnltV3RuYU92TEVQbnBrbWtYYzhVWjRqQmdGcjYyZFp1?=
 =?utf-8?B?NVF4cUJuOWFKb1FhcEJxaWd0WXV5N3NhdkR1UTBJd3lwKzJQWTZNakxaM24y?=
 =?utf-8?B?MzJ1UHZlamFnZFFlUlNGdG1FVjdMV0lJTVE1OHhaSHVIazJra2REaUdDZmty?=
 =?utf-8?B?STAzNjRKMVpuMWJRYzVNY0xXVXp4UjB4M3dtbEpKczVKM3dhbTBFR3lnL3Yr?=
 =?utf-8?B?U2g2UXhvOStaOTNmY0pycmkxbUxiOTBGdkFNemRlOStWbm9xekwvZ2lQRVBO?=
 =?utf-8?B?UlB2bW5xbllpRmVYYlNpdWxQMmZxNFZ2NHFYR0RUYXd6VENXa2hWelU3OGpN?=
 =?utf-8?B?VXlmeVBjVmQ0b3VaRFhpaWtmRUx4RmJaR3dBYzZyVW9kREwvNUZMajRiWmsz?=
 =?utf-8?B?VkUwNlR2L21oVHFLdHNib2phbWMzTHpVQmdIbXdSdlNOVUtvcUhHeURmWEQ2?=
 =?utf-8?B?QUM3cVViY2NHR3Nubmw4WWs1SEpoZzUxemJXVThlckJ2bXYxblg1RHRLcmRx?=
 =?utf-8?B?T3BBbW1TZVRLM2FQKzk1a2I0QWVqd2NyZGtYY1VGY1RuQVBYL1FMYTgxUU5R?=
 =?utf-8?B?K2tJUmZFaHBOUWFxTlowUHVzcXdwc285MWxvNFFVeDBWZ2JuMkx5aDN0SlFu?=
 =?utf-8?B?RE9VZ05sQjVUNUxTeTVpREtwMThueUZjNm1QUEhlaDk5NFNTYWNoSlptOW9h?=
 =?utf-8?B?c051MWhOZWlJNkZieGN2QWlscWFROUk5OS9yVktIVlpYSmRtRE51Y0htYVJk?=
 =?utf-8?B?SFZwNnc2Q1NGT2NkQTNHUXFMaDYrbGg5M3hzWmZoazlXYldxNk5PdmtoUjlS?=
 =?utf-8?B?cUxyeStMc3lEcVNFYktjTjQ4TkcwYWo0Y1AyUS9FOHY2NFVRT0lOTDRkeFQ5?=
 =?utf-8?B?VjBSZDFKamVkMFFueXdEeEt1MTN3cWZ2cFdsY0crWm9WUHFkSmN1MmNVdXd6?=
 =?utf-8?B?czRtaUptREhYQ3NkSXd4STV1ek5IRzlSd2JxWitKUkFtSHZoblN6UTVrMG5w?=
 =?utf-8?B?QWtkMVNPNTIyYmtFTzBDdG5HS2lPUU84TS93QzNkOXlRVFhLYzhaTnArZFNr?=
 =?utf-8?B?Wk9iVGtFcnpsUmh1WWlZOVNkdFdsVEozZFI4RXpWS0g5dldwZytJZVRxbktt?=
 =?utf-8?B?bWROMmVZU0RBOWZtdDJLanRuRDBkemF2MlNjM2JRcUZPRWl5R0NsMEtCM1lQ?=
 =?utf-8?B?RzlPUnJBa01oeG5yUnNSa0FiTUNiLzMzTGJqUTlsZFhMbWQ4b2xrOVR3ZFVQ?=
 =?utf-8?B?RnN6K0JzanZ0ZTMxbkRzbmFxM2dJWGVuaE9PQ1YzL0Y4WXdOS29CNzNqN2Zr?=
 =?utf-8?Q?ItBUwnZeyLtCo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0phM0NiVzlXc01HczZ3OXQwemljam8rKytrQi9ndEM5NGxNY1ZQRHdFYXlu?=
 =?utf-8?B?cGNHOHV2bks1bUlnenZJMDJ3OFVsbmRNQWdFamFzQ1pSMmlRcVhNelBGVzFz?=
 =?utf-8?B?RVdEUzM4L3ZoL1ZMQVhIL0lDSFVkUk1ZSGx2YjkzcWFxVmdYSnpPOUhXSDYv?=
 =?utf-8?B?V0pTUnJjSXFxRDA3SFhJRnk5SERKUzUvUldBZUtvTDZZaDFMRkhySFN2UDJz?=
 =?utf-8?B?Vis1Qjg5eDRVWVNwU0UwTUtXMzNBcWxuUlJmYXZyUTZIUC8wRDMwNGRJQWpE?=
 =?utf-8?B?NlVxTHN2S0RXRnZ6Nk1lb3I3Yys0b2lUWUVDSGVnaUFDd241TG5GL0NCL1Rl?=
 =?utf-8?B?RzN1Ukc5elRtWnlHa2pVS3hvdlNCVXB6MHZrRExSQ09RRVF1K2V2Z0ZCOUFV?=
 =?utf-8?B?U2NlbWJscTREUUxTUjV6NmtJNjFta0JsL2kzVTZlQkVmdzROUDN1dFlZTGQx?=
 =?utf-8?B?RXRncUdIUk54a3ZFajhiUjRCOUNOVjN3ZGRHUUFDN29Jd20xN2hiSEFyK2Jt?=
 =?utf-8?B?SUJsTy92VEpjVWRUN0ZTNTIxZXRGWFQrR2dZQ1lScjd3WEM4MWp0MDZPMWJt?=
 =?utf-8?B?Z3M1WHUrc3AxZHFjRW1CVFRUdy9RS29sMW9sRWRPNGUxNFBvV2RwUE5udXJZ?=
 =?utf-8?B?NWdsbXdkWFMwTFY5VWhVUExQcDZ0VHdUQWg4K1JnanZBS1FvMjhuR3ZuZHBM?=
 =?utf-8?B?SlBUbkwxNGFMWjdjNEluVVJmRFROUExwZ3YxenQ1eTB2ZzJNcC9uWEVkSENE?=
 =?utf-8?B?Q3JGYkp4SW5RbHFZdTBaMzRiQW4wWXBLcWFYdEREYVA4dnhWVkdUVURzeGM0?=
 =?utf-8?B?cU1RNHQycVN3K2srby8xYXEzeFY0SUk5VWE5U1BFYzFDaVJVcTU5SjZqL1lr?=
 =?utf-8?B?dWJyczRicXUyRXJPVktYaXN5OVVBN3k3amlrYS9GeVI1NFd6ek5WdGpIYW90?=
 =?utf-8?B?cWxPazVtZkpSSlNoYng4QVBLcjFDYUlnaUNVUk83SjhURHJwOW56dUV6cFhw?=
 =?utf-8?B?NVhOcTBKdkVBaGY0VTNid1RKb0VKMXFmQ1pqRHc0MDYrNmZvREpEcEVWTkM5?=
 =?utf-8?B?U2hLdHA5TWRONFkrRXBtYnBhWnErMHB3bUZRM0xCWFZZTDM2Ky90QzZPeXBO?=
 =?utf-8?B?bUdEKzNrNlllR05zQXh0N1AwL2NaeG02eXhFOHZBc1NVcm5pdWZ0SzE1SS9W?=
 =?utf-8?B?Z0VXenAxMVZiVzNtdnc2ZmxYQ21VamZyaDRTRDIvV29LWFdQb1hwTzNnYnE5?=
 =?utf-8?B?OTJMTThSdDZoMnRtdS9uQ1ZpbG0zT0pJQVpqU3NjMGg3M3hpeW4zOUl5SHFZ?=
 =?utf-8?B?QjRscVN2ME1kYVpDSms0aU9qTTh1eDBheVByS0FPNUlwUk5NQU1NbWNyMU8r?=
 =?utf-8?B?VHlIY3FkSi9uOTZ4c21vR3FYYTZxQURMRjZJdkRGVHBld3pZK0ZrcjBNZ1Bp?=
 =?utf-8?B?QU1namptTnNiYkEwNXhVUFdsMFBoeUp0aW9FaEdjQUIxcDkwOXB1ZGMwUFJX?=
 =?utf-8?B?aTBtczdGTlIvdWtIU1hiMCsweTBPc25HQXlZczlqanRKbzVVemJpS2dXa2Np?=
 =?utf-8?B?SzFUVlcrc0lJU3hLV3YzNkh1TEl1RlNleDA1aGlLK1AyUDB1dFQ0bG5KQlJI?=
 =?utf-8?B?SlNoR084N2t5ak1oeXZubkZwblhWWFdTaUNXTUFhWXk0TkhCZnFMbC9QeGFQ?=
 =?utf-8?B?ZHFsa0dUUnFjM0ZYUTA0c0pyVURaUUxmWFd5RjVnOWRSekthVCtLbWk5ekhM?=
 =?utf-8?B?cjRndlMvaHdud0FkR2JNeGJTbGRNTEQrZEN3anZOYXg4NFdwWllLQTY1Z0Nq?=
 =?utf-8?B?OHJPb29YaFlRWC9iMHV4dVRHZ0JuMFJpdmNIQzl5aURaOW9lT0ZPRVd0cVh5?=
 =?utf-8?B?NC9iaUV6T1pSRFhQeVNMSDNKaUJUdklWZ2dZTUwzalNrdHNldnhnUzgwbVFY?=
 =?utf-8?B?WExENDFZVmJZRDhHMUY4ekxYWmtwb1E0VmYrb0k3RWxKajYzb0diT3hjM2wx?=
 =?utf-8?B?OTZ5cytFbWMyWXJ0Ky9hRm9acitDdm1UUlNtMTBNaXorZzg4UFAxblovaE40?=
 =?utf-8?B?UnlxdyttQ3d1Ym0xSjQ4M3FkL3BjWGY3Y1k2ckVCTlNFNUowdUxSWExxNjZp?=
 =?utf-8?Q?2JTY8+kGCiGSyK0tfzTUs8d9b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6946fea-8940-4bcb-b8c6-08dd6bbef682
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:03:28.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70NR5mopFiPSnOFkjKEAGcPVrw/sCPM4cfRbWwuyBbkUVw5zchMZeuMr83BTYPG70Aq2SgCS00P9wK2JPdxAdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402

On 3/25/25 02:22, Ard Biesheuvel wrote:
> (cc Kirill)
> 
> On Mon, 24 Mar 2025 at 20:14, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 3/24/25 12:28, Ard Biesheuvel wrote:
>>> L.S.,
>>>
>>> As I am trying to disentangle the Linux early SEV boot code, the
>>> legacy decompressor and the EFI stub, I noticed something that looks
>>> broken to me, but I'm not quite sure how to fix it.
>>>
>>> When booting via the EFI stub, the following call chain may occur:
>>>
>>> setup_e820()
>>>  process_unaccepted_memory()
>>>   arch_accept_memory()
>>>    snp_accept_memory()
>>>     early_setup_ghcb()
>>>      set_page_decrypted()
>>>       set_clr_page_flags()
>>>
>>> where the latter function relies on mapping_info to remap the GHCB
>>> page as unencrypted. However, when entering via the EFI stub, this
>>> struct is never initialized, and so I am struggling to see why this
>>> works at all.
>>
> ...
>> So, yes, this does appear broken.
>>
> 
> OK, thanks for the analysis.
> 
>> The latter function reads from the target page so that the page gets
>> faulted in via do_boot_page_fault(). do_boot_page_fault() calls
>> kernel_add_identity_map(), which calls kernel_ident_mapping_init() and
>> initializes the mapping_info struct.
>>
>> At least that is how it is supposed to happen coming through the
>> decompressor. I couldn't recreate the path you sited until I tried an odd
>> size memory argument that was not 2M aligned (using 4097M on the qemu
>> command line fixed that). However, even that causes issues, because the
>> SEV_STATUS MSR doesn't get read until sev_enable() is called, which is
>> called after setup_e820(), so we actually can't even take the
>> snp_accept_memory() path.
>>
> 
> So we should never hit the page fault that triggers
> kernel_ident_mapping_init() because all memory is already mapped (and
> boot_ghcb_page is part of the image so it will definitely be mapped
> even when not booting via EFI)
> 
> (For future reference, could you share the QEMU command line that you used?)

I used the following Qemu command line:

./bin/qemu-system-x86_64 -enable-kvm \
 -cpu EPYC-v4,host-phys-bits=true -smp 1 \
 -machine type=q35,confidential-guest-support=sev0,memory-backend=ram1,vmport=off \
 -object memory-backend-memfd,id=ram1,size=4097M,share=true,prealloc=false \
 -object sev-snp-guest,id=sev0,policy=0xb0000,cbitpos=51,reduced-phys-bits=1 \
 -bios /root/kernels/qemu-install/OVMF.fd \
 -kernel /root/kernels/linux-build-x86_64/arch/x86/boot/bzImage \
 -append "console=ttyS0 earlyprintk=serial root=/dev/sda2" \
 -nographic -monitor pty -monitor unix:monitor,server,nowait \
 -gdb tcp::1234 -qmp tcp::4444,server,wait=off

Note, this doesn't have an initrd or guest image/disk, so the boot will
eventually fail, but it boots far enough along to encounter the issue
and test a fix.

Thanks,
Tom

> 
>> But faking the SEV_STATUS MSR value does cause the code to get down to the
>> set_clr_page_flags() function and reading the input address contents
>> doesn't trigger do_boot_page_fault() to run because load_stage2_idt()
>> hasn't been called, which probably wouldn't matter anyway since the code
>> is running under the EFI page tables.
>>
> 
> Exactly, and that was the whole point of separating those code paths,
> i.e., to get rid of all the demand paging logic and execute under the
> EFI page tables (which use strict permissions for code and data, which
> is a Microsoft requirement for secure boot signing)
> 
> So in a nutshell, the problem is that snp_accept_memory() calls into
> the SEV code before sev_enable() has been called. But I wonder why
> accepting memory is needed in the EFI stub at all?
> (asking Kirill) Is it just to ensure that all unaccepted memory is at
> the granularity provided by the bitmap? That could explain why nobody
> ever noticed this.
> 
> Is there a problem with being conservative in the bitmap, and marking
> misaligned chunks of accepted memory as unaccepted? AIUI, that would
> remove the need entirely to accept any memory in the EFI stub - only
> the decompressor code path would have a need for it.

