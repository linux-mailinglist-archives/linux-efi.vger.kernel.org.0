Return-Path: <linux-efi+bounces-4580-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07CB2E05C
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 17:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABC06009E6
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745E341677;
	Wed, 20 Aug 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Et+K0mol"
X-Original-To: linux-efi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8A326D47;
	Wed, 20 Aug 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701950; cv=fail; b=S0DQCFpbR9oehwHE2ddt/IjqwULYVKevhqXyPcifXITiGZacewUdTezzyzb9+EiSXZXSu1vLt3Ww+ND036JDEOeCUResOfkJTQ+4IdUT/CMgtmn1SvEQlWbzK6n1mPspAMv8f0Twp8VW3df7D650TiQwtKgmaSDT7C2uuTjPB+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701950; c=relaxed/simple;
	bh=4OUg0i+gEfuT1CD5bK6msWViyZkscXfJ7FvF49HVdHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTq11HJvedzhVSzVSu1ygw7WsjnKi8WUA8qsxsK9xlOFwyhx455sJh9LMru7/BaJKuH7qs8xb4Pm4qRvA9I4CMwkQ6ogY3KoqXvU+bnhrHlWMRWi6AmL4Vl7QUiqSxUSuJlZjVyHnXdRP4EkoBFOn6GswcieJn19PkUhGx5wZJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Et+K0mol; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciDzTrDlur7kYs/HZ8TUoKPhJnH4g2YTUw6qWkQzXupTe48TFozDzpTB+wQTqsBOJqeAfiUKZwACdudKvPagR25Lg+XMDEDn7nuprogCgaIiIhR3RXd7ARsDm0ItVTlIhbNzMc1wn74I0dIJJbNpxSAhh9ySV4p5X/hf5m4Zl22aaGEohrNWRMjwThvFkMrCNnJD6AqzvIEZ4razV4s/QNQgViAaSvlWd5qrHffTsYiVFnR1b+svkmtaVcHSEo5eC58TL0rfuomTKBUFZOEAL5p32rIp2VhEpVsnAaHLFQ/fiFK5qcQzEccL4fhN4o5pv2C/1Ftvg0vnSCt5WkBC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKut68sRpIkixU13gzv2e69CT+3qCNcpj9yHBcnhYUw=;
 b=UU2NWzbPPiVgoOwUWHzKJYiJMdkAq7FY7sEq3Z4xDZCmkuDsJePEvTdpL4DD+D4f560TABMVMGh8853zErZBxH+MVlbMwbBRayAVz/wpIB5cNB4K+Amw+o6OrJRxMEKXzuRQhsbSzzHab10+jCOpEsgGNOImdvFAllplYmB5L7VoJnUXWvBnArhdNbBHHQCuCFk1yOWRDOsQjN4BxcPeieMaTLKVjPpUC4QzEXPgf0iDV4sqPa/jGzm2Mj4p2rW++XZoaqzMIL96Cz3tT2t0X1Byvqve0l49SZLabHo131FHMrwyS5cbXtYaJso/8tEYNLP3yzlf/TYRn/NFcgquxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKut68sRpIkixU13gzv2e69CT+3qCNcpj9yHBcnhYUw=;
 b=Et+K0molg8NcDj2rP2aGgDAdJIZBYN8YaGoswnX+BRYD9XfGVG47sMjB9/ncTthB6Y9FXA6TRywicXV6xCL61YjULJsZTjf7GCbm+IndVn5IDVB2S87kaOffVA9TgwPZ9FWat+mgYlik0m3XbZjj+NY2MeheJAFPHdis0Naf8KJvSbsCTB1MUXyy1zgcBP0jwn7pZK6vie5gOAXo1cJF/jojPBeVYIb+a9bKRGY6GcRJwroRT/5G4sWfYnvm/0PM3IW8jqwaGyJURQWSwesbHU/eyF8VHlp9X4sLTZ7UNKHBP34CJ0Dm+6U4OD9ghRup7aOZNHxG8tGL2tc+NW/Ohw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 14:59:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 14:59:04 +0000
Message-ID: <50f7f2fc-2c6d-4ae1-bbce-e132b1d9c9fe@siemens.com>
Date: Wed, 20 Aug 2025 16:59:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
 <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f35c037-f412-442d-c1ae-08dddffa1b1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azh6cUNGcHpOeUsyMnZ0SE9JRzcvT04xbCtESVU3aDVoaEFJZ0I5dFdjaE1r?=
 =?utf-8?B?d0NHMFJyd0xqRTc5bG1OUXZydlJ0Vm5kZ1hxaXI4UERpdE9GbHYwZ2NHOVBp?=
 =?utf-8?B?NEgrU041Sitac3hETVRNZ1U0dlFhNmlkRVJlSUl2dXVhQ3hTNnpucXFCa3Mz?=
 =?utf-8?B?a2ZhSkVPYXBXUXdHeTBHaTI4ajBDRUx0N2c4bmZXNnhtWDN1RlYvdDViQTdh?=
 =?utf-8?B?c3UvS3hCNVM2eEsvRjVhMGUrV1g4c3BLRHVyQmNxZWp4blY0Z2kwNFV1U2tU?=
 =?utf-8?B?SmdJWklYMTdYOEpyUVRPUTA2MXVrQ1BWditJVUhGOEh3VjlseWN6V1RzcFYv?=
 =?utf-8?B?QnZzNy9wOWc3dDdLZERpY2Qxdm02UG5tcER0dGFBNEM1OW1SVnE3QmVhdVVy?=
 =?utf-8?B?SzZFUkdOYUtQUFVOemlYWjBMazFmSmZHR01IVTBKbTVrdnRzQW9EV25vckVm?=
 =?utf-8?B?TU44LzlDZDhnSndiYkhCcC84TksvQTQ2RGlUSTBJcUpSNGJLQm43WkhRQkl5?=
 =?utf-8?B?T1lMeFBkUGgrdmwzMHVqL09YMk1POWdhUzFoWXJUbVJURmdZbXpzMDhVVFA5?=
 =?utf-8?B?dklLZmxRU3c2dVVIa01pUmREM2lydDQ1ZHNrMkp3Rk43ZEJGQ1c4cmNaWno0?=
 =?utf-8?B?VThtSFZqUkdaT1JPVUhLTjliT01OTXlNNHF3WkE1bzhGaW0renRaTjc3MFdS?=
 =?utf-8?B?aEgrVHNnQU5NY2ZEZWpJc1EvUDZoRUJ5bkhKRVkwTk5tNGtjOW52eitCNFBE?=
 =?utf-8?B?eTNCV1oydCtWZkZlL0xQY2pSZ0NTbXR3VHVtR2k3SDFGTFcyemFNcExPVG5I?=
 =?utf-8?B?ak13Qm1GMlNQTkNqMW1HMW5JUzYxbzZiU3pVTHJrMVlFWmdBTEkrRGM2Tnpp?=
 =?utf-8?B?UzNQMHFXU1pzVmRDUDRIcVBtQjZYcFJLWEFvczc4bFc2TG45RmNQRHd4WXl4?=
 =?utf-8?B?QXlSY3pBcGhxeTlEUWZoYjRZNHZkVmx5dVlZN2o1N2ptR3FyLzdiME45U0FG?=
 =?utf-8?B?S0taSHNFZE5vVmRGbTNEdWdjM0xxZ0wwRHUvblNabEtudFNjRmRqSkRrN0V2?=
 =?utf-8?B?LzFlbXlWK2crUjV1ellLbUVxVFlOMHlwdmNqUUwyQk9rWjg5SVNQZkU3Slls?=
 =?utf-8?B?SHFNb3ZYR01YWFhwVSs2WGN6RnkzRGFDenBheWNmRkdjZm9wYXRrcEFQZ2VE?=
 =?utf-8?B?TVBLdmRxYTFFM1ZyT1VYUmlkMExUTjNlQ2k0bjlrQUdoU2lxdkh4MmVVZmpy?=
 =?utf-8?B?L3ZqaDdvMVhvRGpJKzZxK3pIMXZJKzBsTG44TW5hR1l3NmRUUHJLZ0dESWVQ?=
 =?utf-8?B?MW53ejBVQ212ZW9PREFzbHhETjdqMG1IM1JJSEJRUHc4SFNGODV5Mmhld1Jt?=
 =?utf-8?B?OGxBZG1MSXlmbTkwZGhWKzlPYjBJQ1c5Y1h0MW1hdmNmU1FqS3JxMnUzeTE5?=
 =?utf-8?B?VjdsMXVIOW5PSngrZ0JHcmdON1E5a1JVYStHRjgvVjYzOUFPMUZVZ0FadU93?=
 =?utf-8?B?MWVJczJYKzAvWTBRekVEZEY0dTdlcFF4alI4b3VXZ0hVMEpHcWc2NUMzK1JG?=
 =?utf-8?B?cUxoSUl4em5WWC95NWMrRnY1azBwdG5IeG5WalN5dDNEb01EUUZGQm9EVkw0?=
 =?utf-8?B?NTgwdDRBdDJKblYyNDhQTVlteHdvd2gyMlJlK1d2Q0lCczRQdU4ySVp1elkv?=
 =?utf-8?B?NlBESEY0YXFQZ0c3WklMbUlBWG5LSG1tMlVGaWVpN3VneFJNZ2Y2R0hyK1RZ?=
 =?utf-8?B?NFFqbk9Nc3lkbVdyK04rSHdwOHM5dU5KNjFUdGhHS3F4VDZzQ2xHYnNhaDZi?=
 =?utf-8?B?VWJDVHN2NGhDN1ZTSGI1bUovdW9zMjBsQ0xEZDF5RW9wZzdmTm9OdkdENElp?=
 =?utf-8?B?R2FpZnlyNGh3aUcrd0lzM25sNTAyMmxsZXBQL01jSWFKcmVpTnRsNTllMERC?=
 =?utf-8?Q?yllWWjRJk64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDYvK0J5cHdTZVd5d0NDbjgyLzhHUzlsL0o1czlLUGppNDMxcVFwRDhoYWFq?=
 =?utf-8?B?M2RIcW45dU1maEhKM2xPNDNHSlVSWFYyTVBVWklvc0tIZERacCtMVCtTeTZh?=
 =?utf-8?B?ZjFVVTFuN0dKS1hWdUNvZVZkS3hvc3FpbFp6bVh0ajhON0hLQ1ZBZUdzc0xs?=
 =?utf-8?B?SkxRb2YzVzRnZUx3ZFNlalJyNzNvTEN2Zk1vdHFWdUdvdnY2d2FEVUwwWG1X?=
 =?utf-8?B?bTVCYWp3OWdUSFBic0FLTXg3OGQ4V2FLSExXV0VuZWcxeXVLZENpMTJqdXpF?=
 =?utf-8?B?TklMd1RsU0Z4dmd3RGdEd29Ld0dJd0xrNTNMVVNmeGxadWV2Q1NpbmUwVFJp?=
 =?utf-8?B?cXBIRTI4bXRwSEQ4U1NpTnhTdmQ2bE5LT0lIZVhEQTBIOFEzaE9MY3ZKRURI?=
 =?utf-8?B?Wk5JMVdFVkl1SVViSzNCOWtWT1RZMWR4S0hibTFPY3J4MTVNWGpUa2t6d0lk?=
 =?utf-8?B?V0tmaEZmaFpjYURZZzhjUm1HWEEzMDJnSkpKQ1JzeXowZm8rT3pQQzZiR05q?=
 =?utf-8?B?czFSTEppOHJZSEJENkttRDNRMjkwekFXZmM1R1VTNHBVN1BPTHM3WGtPOWx5?=
 =?utf-8?B?MmJCOStzMGlRaFVnVWc3TVMyL29FUEJnMkhtcG8vNHpKemo4ODVOdWhmUGFU?=
 =?utf-8?B?WS9IZzd6LzJ0RjVlY0ZGbC9mcmpoYk1UeU15NmpoRHQ5ZUp3enQxTGNEbGdm?=
 =?utf-8?B?amJQWFlqSktrUGlvaWtsdWNQanlYTDkzUWxnMTdpSHdkRE5keG5SbEdvRXVY?=
 =?utf-8?B?dnBHMVI3YjZvTGtGNk8vckluUll1R0taZGYwOTU3ODVwR2pIQm1oSDIwaWs1?=
 =?utf-8?B?TmxLKzFnY1RjRlFZKyszV3MyV1FZY2dBclp2ZDBsWU1BUkxmbHI2LzBrb0ZG?=
 =?utf-8?B?TVNrUi9oQ2k3Wk15SGJSNXlmK25zRTc5bzJIY2hpdW9yT2Y4T3pQR1RJWU5T?=
 =?utf-8?B?dlRPTkRpQnkxNVJmRXl5QUtPemlRQXVSM1NJY044Uk01OC9VNjZMMThrVXpk?=
 =?utf-8?B?b3c0RVlRMTdYRlR6VVJvOVhYaExLOTNZSkhYc2FQWC9sZ29XYU9kYTJJd0JZ?=
 =?utf-8?B?clRvdFBHMTZSQWFOREhsYWNUREUrSGowSDZSak1sL0dnZ3RKWk1jamdqU0RU?=
 =?utf-8?B?YitUb0JERUZWbUZBWXBpbjE2OXhyWEFnNFVaTVl1elB6OHZlSTZtMGRGTHJh?=
 =?utf-8?B?b21jUXpnV3pNWFNoMUhYVG11VUJVMk1JQ3JHTnlRQXNqdTJiK2xxTksvNUdW?=
 =?utf-8?B?MitRSWNibFRSaXRnWnJPQVBpRU8yNUdteUxRSllNZ2l6RmtKUk1ib0xFSXFE?=
 =?utf-8?B?REZNRU51dUVhKzgvMS8vb3gybTQxZnVsaWZXSVE5QlorYW9YSjRQeVpoM2lw?=
 =?utf-8?B?cElyeGxhYkRNc3Zja096MGM5NU5VOEFpaS9DYkNnVjV5NGRjTDJWcEhzL3Vy?=
 =?utf-8?B?YzNhNGhmUEJxSDUwVUZyangrTFZ6dlhaNjVtWG9SNmZKS2o3NXRKOCtFWFB0?=
 =?utf-8?B?bVdDU2hyeVU0dEN0UEJLbG9aN2g2TUZFc0FRaHNOeUpGS0V4RjY2S01HdXNy?=
 =?utf-8?B?RkxSSExpcnFrSno2SlRMdUlkRjc3aXlpUkU5UnJkYlNZcFNkd3J6NzVEYnpS?=
 =?utf-8?B?ZG9zcURWWnJxczlZZjB1NllIOGx5RzJ3MndBMFpDR2drN3puNEZTbjR0WnUz?=
 =?utf-8?B?eS96MFV2cFJxMmxtWGtLeTBrcmVmWG9QZWtYVXB2UHB4QWNwK2VYWHFRZ3FR?=
 =?utf-8?B?K3E3U0wvbHB1TmdqZ3A1bjFpcngxMUhkV3R1RGpqYmJsemlPb0p4UFJzTnN6?=
 =?utf-8?B?R3ltVTNVdTd3Rm1XQ000c1BBdjludFVGUUo2QmsrSEZFVUxUQWdYelYvcDla?=
 =?utf-8?B?c05uV2ZBTjZCU3YyYmJqUkpVTEZiQ3FWTVNuUTZRcWFMVm1RZHFtc0tHeDd3?=
 =?utf-8?B?N0FVczl5UlpZNlBYKzVsMXdqQWV5dWIrdjVYMTI5MXRJdE5Ld25ReUNvZkp0?=
 =?utf-8?B?T0tzV2NVM2dUODRraTluUG41am9RS2xnRTJSV0N1enBseDVtZkt5YlkrUndz?=
 =?utf-8?B?ZkcwOFJ3U2ZQTjdMVlVhUytVa205N2h3a2hkSDQ0dGVRcGl4K0V1VmpVTGlt?=
 =?utf-8?B?djhUQkpWTUVyeXdZQ3NxWVhLaUVzYnBncHd4b2IvTFE1Uzh2bm4zbTh5VjFt?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f35c037-f412-442d-c1ae-08dddffa1b1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:59:04.7956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBVHamX1xQ/JedMXJ6UH0//4t7jUOf5schEpBwGBnhdZJ32HuRli7/sN/57BVDETO0Rk4MapzFI8BlifhmxiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5646

On 20.08.25 09:10, Ilias Apalodimas wrote:
> Hi Jan
> 
> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> If a too large payload_size is passed to setup_mm_hdr, callers will
>> returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
>> passed down via ret. No need to fold errors here.
> 
> Apart from not folding the error here, the current code kind of
> violates the EFI spec.
> If you look at GetVariable, GetNextVariable, SetVariable, and
> QueryVariableInfo only SetVariable is supposed to return
> EFI_OUT_OF_RESOURCES, if there's no storage space left.

And with storage space is likely meant the persistent part of it. ENOMEM
is something different.

> 
> Should we also change setup_mm_hdr() and return EFI_INVALID_PARAMETER
> always? It's still not ideal, but much closer to the spec.

EFI_DEVICE_ERROR? The "hardware" is has a problem by not providing us
enough RAM. Yeah, not optimal either. But invalid parameter is clearly
described, and nothing fits.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

