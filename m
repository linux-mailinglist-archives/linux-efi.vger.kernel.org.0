Return-Path: <linux-efi+bounces-4581-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F216AB2E0A5
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C703CB64E93
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A33375CF;
	Wed, 20 Aug 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dE5W+mf4"
X-Original-To: linux-efi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB9322DDA;
	Wed, 20 Aug 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702350; cv=fail; b=sBavxARX0BLTdsKcNrmfgmmLDTvG9mt4JlDrLOPTsAHb/Fee1ez3xl45KfeaCCRdPnf+o1C+QbAxaLr4cRxgbCY3okqWa9x1n+RF/rpV323uGdp7+X7ySsqwSza1DtLmNO1N1IrcYQigBIv00jUYxLNB30bpL9ZfVePFo7sL9sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702350; c=relaxed/simple;
	bh=dLqNkdd6v9qgzvuejCDkz5saCnntTlLA2GNpANkhN24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=adIstBYSxScpRldDaH4CxUgXw8PTHwSzPhI/v3FUWAf3iAYTdoa/iHpCmfHOcJN9L2YJq6yJQCrqSEf4zV1NcCeojdHJEb4MH632+d4SjNLCanJO/pb7mhaRiLYl/OqtsCXf6jPZAKpGFmwZDtRbUytIB4TKWIN9LkMHzrhH2vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dE5W+mf4; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kkqjpzpw4hhpUE1Ow8ZS+eG37TXUKJkByu4Ha3X8mm65JAUCVHECATp+DN4SEq7yJpJDsaoJdcuPwJbVupG2Pmlu4qt5hcB8TcbaGR5fL5KVjCZZWypbWJVc01v3lpf1Ds4DIzbZ4BPuN+OZ3mvZMqgZBonwrWiS4QZETgNQVBLWznNGkKtqGBD0HH2LeQX6JUEmnBMW99VbKeTzJIT8x/cYMFmvJoZa95jaFrRKtXevi9QayKY606iiJP/mokkMLkVkaVNOwoD3i8vL9jmPKBpAm0GM6VK/Y3E7+OzA/wfD20679uHtIt3zAVWCpgCZb/6pSawzGY6bYRxGeavC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmLCh9RCvel7z5YSFRIjk59DxVirjVZI/7hil5+qpCk=;
 b=i2XMJSbRwQCz9L+JHqe6KoYHUogb56ALon8AFcJHIN1m7cQRgX62b1tHxWLxihVvAOkVkFHc9rFcFqQ1I2M455uuCFOOHAnpNlQccUZaozYY5Sp3hCc5qq8swDodunXScENhVvRnoUMjjvHTjrG9Ng2eEcVY7VnblggzbC09y3TRiuylnbVlbREQAycWxNcYJg3mJvlS8cdawHjM3WqBCu22dZciH/6eklY1d9pyTsUPWITttJOOtIGbldi8Fffz/ZxrjO9Dq4Xu7QSEzmihvAb00algAJvHJ/4gIRp9ySJ0FURhfnTXjrVfm8qEdbOavC0bmUmrG686VzvIhoR8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmLCh9RCvel7z5YSFRIjk59DxVirjVZI/7hil5+qpCk=;
 b=dE5W+mf4u3qsnSopfNFaYRH+hkuk1Gwm+nJ2/T5yqHyGDWTLt1Rm/7+JlwVemCbcPbC7/L0ls2V+VfdMilbWyNEvISA0ZI8ndTL9YAb0ksgufg7N0HSDiuAIpMdAWEAHtXSIJHrmL4cuG6dKDimcEJVAn/beWopedSqK8NWoZ9Gx3waW7SRmNERVXMBOcW0lrnILZwkvsVRom8v3rGVX4TCRfN5KfQXoGTjlOhhPzNy+emsAxHDq7fkhQvE25wWm/wlDUUyQs0Zwt8ltwyOE6/XxpgVt2OeFaeEobCfgyuf2OV6WIhWqSs8buZ4qcw3fJHE+TUcS1tQaXKUk0YuMYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9451.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 15:05:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 15:05:45 +0000
Message-ID: <75db5f5e-9e0c-4c48-a3c8-034414276036@siemens.com>
Date: Wed, 20 Aug 2025 17:05:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi: stmm: Fix incorrect buffer allocation method
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sumit Garg <sumit.garg@kernel.org>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
 <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjL84EFiKh0ETb7LwYjMRgLAZA8hFKy-YDS4=YQ1LRwg9A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjL84EFiKh0ETb7LwYjMRgLAZA8hFKy-YDS4=YQ1LRwg9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: cb914b94-9283-4ef4-cdba-08dddffb09a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFR1T1IrblFNL042ZDZnTTlJaHdFZFZ4eXdnYjVBLzd6eXFwenhONUJtNXFP?=
 =?utf-8?B?SjkxTTNuclhoRkNqNXhLTWVsMXNNZzNBVDl2WkNZbXVaU1FLL05iNW5YYUMy?=
 =?utf-8?B?b25LbVdTeHBCMzhZVjQ5NFFTVWhJQ0lPMS9kbUlURXJQTlJaU3dGd0lGUE9s?=
 =?utf-8?B?NzBONy9DcGovUHl4SUlUYkxKNXFhaUV1cE0yUU03MWRKNDhVVE5SbDRjSEV3?=
 =?utf-8?B?S3h1bkc1UHdlSDFVZHdabENnRGZSYVBmWDFvczltSXBIdG0zZ2VRWVVNeFJC?=
 =?utf-8?B?Q2dVRDE5WEFpRmQ3RjhDTXpWTEExdEFKOFFxRFZpNmc4N3h0VlVHNS95SXh5?=
 =?utf-8?B?UEo1eEU3TU5yS1V0c0dwa0FqYzl2dVlqR3E3K1dCNXdKODcwMkd3Vmo5T1VM?=
 =?utf-8?B?UFJRQTd5T2VNRXpWNisxdVpmNmFuUjdjL1doUnZCMmEwaGFJTG8xUDFhUlow?=
 =?utf-8?B?RnBJOG9vdEwyb3BFcXZGME0zdTFKaklOajBHSmJvSjYwYitnRFlRL0lWd0ZS?=
 =?utf-8?B?eU5IMmlKaDQzTVR4eW1HOEY3OVJiZzhNTEhDdTBxQkJ4ZTRhcFlHei84ZHRL?=
 =?utf-8?B?eWZvT1BJczJYdGR6aWV1L01GL1R1c0NUWHpoVklGd0ZHSWVETzVzTVd1dUZq?=
 =?utf-8?B?cndnZHFtL3ZQN2NxMjFGTVRDUmt3RGw2a0ZmRXJQNHNMS2ptWW1ORXhzLy9Z?=
 =?utf-8?B?UzhpV0xDenJrRVEwakh0Z3JBSzV6RjRpSjZHeVVZc3J4RTMyeGlsWEh0Mlkz?=
 =?utf-8?B?b3ZVV1ViSGV6Q0ozZkk1ZU1pRHgrOStJM2kvemMzV1ovMVZQaTJDZ0N1T1U4?=
 =?utf-8?B?aXJjSkFBdWlNNkNtSmJEbTF5SWRxb2s2SVFLM05qOTBiU1ZGNVIya2ZTbGdo?=
 =?utf-8?B?M3E0d3ZWekQ5MFVIc29iZEZjTjZFSjNNT0wzd3FCUUJNS2xoVjhQSXVza21N?=
 =?utf-8?B?Snh0Q1Brb0RadldVUnpXMFc3RnpHS0ZvaSsrdVlvNDd2RnE1OEhHVTRONTVq?=
 =?utf-8?B?aUNhUENtY2JNdURCb0lGYlFxNGNjRUFDMC9pZWlwSS9Qb242aG5xdFp0V3No?=
 =?utf-8?B?TE0vejZlZ01SbUoyRjRUMmQ0MWRSTmZlWnI5a2Q1dmozNzE1ajEvRm1mRGtl?=
 =?utf-8?B?b1FNbzNnVmZCZlhRT2Npb0FRTXdsWXdxeUZiNVMyTWJIQWZUWW95dDErblkw?=
 =?utf-8?B?QyswNldZWmRXaEVXeEtqUzBtTFZXOXphekxOYkZlalUxTmtOa2ZXNDBNdjlo?=
 =?utf-8?B?TDZNV1cxd3B2ZnV3U3RRVm9mMFpvRUlkRVVoRkpuVHRESzFSbG9LaHk0cU4r?=
 =?utf-8?B?dlpldHlldDRxdlkweGU0akpWeWtlZjRUaUFJVGtGcEJlN0pLcElYUFhUNlFt?=
 =?utf-8?B?ekx1d1h2Ym9tMldDdFB0ek8yQm1kdkMzaVd2WDNQYXkzdjNjWWxDbUIyVlBi?=
 =?utf-8?B?NkRGYmp5WnVzUVRLakhzMVR4a2FSNWsvSEZGaEt2R3o4WVhjUDVON0gzS1F6?=
 =?utf-8?B?VGNXdlpqVXNhS0VTdldrRWV0Yyt2Vnhic2xxTmtJUmJxSi9SS1ZuSG56emF5?=
 =?utf-8?B?QVh0U1hSenY1SS9BVXZJRHArK0VMZ1dhT0U0K3hhdFRFNGF4T1prdXZqN25U?=
 =?utf-8?B?L0l0TDhheDNPYUNhM2N6Wmc3VlJjYlpFVFQrbTFvUnFrbGQ3MDhCUFpQR0gw?=
 =?utf-8?B?Ri9OT2Y0NWFUNjlRVS91VCtiUzd6c09hQk1MN2Y0V0haV3lBdThrUGFsQW5V?=
 =?utf-8?B?c2hEQStLdW5OallCUGdRa3p1RjMyYmlNMWJBTExoVXFjaHIvcWIvNUV0eTJU?=
 =?utf-8?B?K3E4ZzlUaXliQTJiSVpBaDRHSE95cll3WGdhem1QRnh5akJtZVZwcGxjOG1M?=
 =?utf-8?B?QXc3Y2pOSDh3azVKcjU0QmFzZkpUWFlUMDRWNHNMeTFhdUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ZKU1lycCtDYUNvOEhoeHhzbGNneFBlNkdWQmFhenNONVlpMEQ4Ylo2a09V?=
 =?utf-8?B?OFczQy9iWFpqQnJ1RVkyNUNRWmpTU1BISVkrVkh1N0I5NzlUMVR6K1g4eEVJ?=
 =?utf-8?B?QXBMOWRlcFA3dGJja3NaVWhxaE9xcWVNSnNScjJHeVZRbVhKdTl2MDY3Mkcr?=
 =?utf-8?B?LzBJVWhyeUFCWUwveDBPNzlLSGprYlg5SGtRSEFDS3llVUpUakJkOGFyeDUx?=
 =?utf-8?B?Tkk1TXZqM0ZuWDdaK2ZMVWJqb0EvQWgrNnZpZ3lwVmcwcVlzMFpsZEowL3hG?=
 =?utf-8?B?ci9WaTlmcEhvRXJRV1ZYeUR6T3lELzlRTDZ4VVJXaGZBdjBOVU5JYXVJVHg3?=
 =?utf-8?B?M2ZTSzdBQ3hrSEI3cTR6VkVZc3R1KzNMcnV4TGl3cVEvY0tFQ3dWbFU3ZnZk?=
 =?utf-8?B?OU5nYWZSdVF3T1JENUYxYy9UeDBLUWhxTzRhcUQyaFVYcWV0NDVKWHo0Njl0?=
 =?utf-8?B?c0hxUzRxTXNRZ1VNZ3Z3aTVWZTAxaHpkTWlleTVyZzJocU1ZYkFxKzV4UVZ2?=
 =?utf-8?B?WmpzYWI5Z3ZNS0tTRXVITS9ENllUdDVEQnFlUU50dFJ1cm1USGtjVks3Ykkv?=
 =?utf-8?B?M1I1cjhZSm03VEFSdldkRzZiZTlld3NXQjNVN3lFUkx4djFweHkxK3NmNlIr?=
 =?utf-8?B?WWNiTUNSUVlERDlkejR5QmJyWDNDayttYTF1WWxvRmF5bFVQRWFjSWZ0emk3?=
 =?utf-8?B?TnhNQWgvb0NtK1E2bjUvWXhSQVlPWVVpZEdlUzNwTHNYd3Zwd1VCUENKREFZ?=
 =?utf-8?B?VllYbHpEZWdTOG5wbnVXNXY2dThQM0V3NGpsUlhzdWhSZkRXT0I4ZHpzWDVx?=
 =?utf-8?B?VUZSWjExL3JzQjRDRGxJakdwc0M3bk1hTXZ3Smg3ZkJyRTR4UGdQSUVFZTFp?=
 =?utf-8?B?ZFcvcEprWm12RzFtMFNldWVsQTdQd281TnhuLzM2MWRBbTA2c0F0dGlHMVln?=
 =?utf-8?B?bTBGZ1NtSkJoa05zUUc2VGRUVjNmbWllckgrMUdnd24yM3pyNlN1ZTczMWt2?=
 =?utf-8?B?ak1hRXAxbGdPUXluMzhnWkVPamMyMjU1dUhOMi9ZNlVkM1QyK094L3F6T3I3?=
 =?utf-8?B?U1dkV3BoRGJROTZTQkpEdlBVYVFmdDh4RW8rQTRoQlNjMVMzR0JMeUNDeStZ?=
 =?utf-8?B?RjhneEg3VHVoejdqRzVMZGJUTklwNWtWUGpPcHBVN3IzbHNJTlArYW5CcE5z?=
 =?utf-8?B?ait0R0F5QWFUbUJBNk5XU01VUWVTZ3BYbzJvUURud2RrcUNHR2pOaVdmRXZ6?=
 =?utf-8?B?VDNSOEgvdW5Zei8xY2NUZWpPL0ZlcENyZU4rUTNkZXJoc1QxeHVJMEpVUTVX?=
 =?utf-8?B?ampHOXZ3cWNQTWV0UmIwVW96Ukk4bC9ORW5IaWw3WnRSa0RmaWdsaDcwbXkx?=
 =?utf-8?B?MnNlQ0ZlVzhJZWhSR295T0xBVWp6cm8zSmthWm13UDVlY3VibHBhaDZGT3VC?=
 =?utf-8?B?NXNqaVUvVk9tSEVObTlUZ0hmenQzRXRaMWU2d1FkNGVTNkJpNUlBSE9RbUxJ?=
 =?utf-8?B?UFdkbUo1QURXOGt3UEFDWE4vZkd6OTFMamFkc28renlhT0RKMytxNjhJL0xE?=
 =?utf-8?B?R2pQM0haVzNrUUdqSFJQN2pWdnBROEc3aEpBUCt5WkptcmJmQVR1azd0QVhs?=
 =?utf-8?B?OVZmaURXY1k1dHZURXRPV05vTWlrS2c3U0FzdXpWemNOc2hMNU1jekdTTzc1?=
 =?utf-8?B?TDduaWtEZG5WYVJHcjZ0ZHMvUzZaOVFjWEhaaEE0NjVvR1BTQkZYdER2NWhl?=
 =?utf-8?B?M09qanJ2dWJZU3FXaDdleCtFbElTSTV5ZlRWUm1wYzhWSWFtREZQb0Nzby9S?=
 =?utf-8?B?ZVdJS1NEbkowSFBCWGlXNk95TVhmMmJ1NVVRL2ZBRHN1VFhteStIeG5HclBM?=
 =?utf-8?B?Y2ZKbzNwcGlmRTFTWFMxaXpBeURta0NrOVZQVjhDVXJnZnZPcDZKZUpSU1h4?=
 =?utf-8?B?U3djQnVxN1FNTkQyNHc4NEIxYTFjRmpya1NjbTcrWmZ3TlFoTnJndi92RU1h?=
 =?utf-8?B?MHVnRUU3OXRMZXhPRHVGYkV3U2ZwV1RIVUhBQnZ4WWIzdFhDM1JWVG9taSsv?=
 =?utf-8?B?Q25HNmtsVVk0ZHBNZDlMclE0cnVZckhrTS9Sb3J6eVIzNWtTcW5oN3RyUWRr?=
 =?utf-8?B?NUxnMi9hNC92ZmhBQTViWnJuY21iUm5EUnNXdVJvM1VXLzV3c0hyN2EvVWY1?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb914b94-9283-4ef4-cdba-08dddffb09a2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 15:05:44.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs5h3ay7lnvtfPNQYEkbV5fFd1G+hg496hW1UZcKCAXtdj/UKMEca4IFs5T4+1KIOo2YmFraMwFBCewpzbzMAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9451

On 20.08.25 09:29, Ilias Apalodimas wrote:
> (++cc Sumit and Kojima-san on their updated emails)
> 
> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The communication buffer allocated by setup_mm_hdr is later on passed to
>> tee_shm_register_kernel_buf. The latter expects those buffers to be
>> contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
>> various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
>> was broken before as well.
>>
>> Fix this by using alloc_pages_exact instead of kmalloc.
>>
>> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
> 
> [...]
> 
>>         const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
>>         struct efi_mm_communicate_header *mm_hdr;
>> @@ -173,9 +174,12 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
>>                 return NULL;
>>         }
>>
>> -       comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
>> -                                  MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
>> -                          GFP_KERNEL);
>> +       *nr_pages = roundup(MM_COMMUNICATE_HEADER_SIZE +
>> +                           MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
>> +                           PAGE_SIZE) / PAGE_SIZE;
>> +
>> +       comm_buf = alloc_pages_exact(*nr_pages * PAGE_SIZE,
>> +                                    GFP_KERNEL | __GFP_ZERO);
> 
> Rename nr_pages to something else and skip division, multiplying.
> Unless there's a reason I am missing?
> Also doesn't alloc_pages_exact() already rounds things up?

I was looking at tee_dyn_shm_alloc_helper and the dance it does to
calculate the pages from the size parameter. Digging into
alloc_pages_exact, though, suggests that the get_order(size) there will
already do what we need. Let me rework this.

Jan

> 
>>         if (!comm_buf) {
>>                 *ret = EFI_OUT_OF_RESOURCES;
>>                 return NULL;
>> @@ -205,13 +209,14 @@ static efi_status_t get_max_payload(size_t *size)
>>         struct smm_variable_payload_size *var_payload = NULL;
>>         size_t payload_size;
>>         u8 *comm_buf = NULL;
> 
> [...]
> 
> Thanks
> /Ilias


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

