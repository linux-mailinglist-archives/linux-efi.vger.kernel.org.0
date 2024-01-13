Return-Path: <linux-efi+bounces-403-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD082CBE3
	for <lists+linux-efi@lfdr.de>; Sat, 13 Jan 2024 11:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808E41F22A3D
	for <lists+linux-efi@lfdr.de>; Sat, 13 Jan 2024 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397F120B2C;
	Sat, 13 Jan 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eJgTKaUx"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51E125A9;
	Sat, 13 Jan 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFQKhPR8V5MfRJiLQAmhtxBr3g9HK/9Rw9y9ro7y9/Helwjihc6M7tJg1ce/6p5OmBGrjpH1Ogb/9tgXa2mwmhVH2Z7RHlHyp1fLE9fYsIcM9Ym9LBODXloonTcHLBKcm0w4rqUEa3wJpM1ExuUfhefMN/HmPYIdzeNkJEvSEF2pb0dZbaWtFy57VfVi81KxFKVtZyWogHuO50DxjdqSgnwBOD9pmA9Bfk8jgsyPvuCPOgKc9/D74Cql1Hso9oYzhs3i4l46gt82+fByItZ704V1dimsf/TaEEqz6Kt8XMUu0v9LnWZ4cW0n9xwIsDO/E6cZna3y3bSL6HDfCt53Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D08WhUtKwQHu948ULbw9LED7r4HhDb5s0MW6P71IlIw=;
 b=agaprVguopbCzRvRiQ5TgfQHw2bJmeKexNIioCRC/NFTTDFNp10mpL4XdVKqWKwcI2cwC6C7rQ8aEnDSVDMufcUqLfN5+cgARVn6TO6SWvZrrbGnVINv9AL051k60ea7J0GLyASj+dVW3QCxml5XhYIS+d05vnWkV/y6kMdQUrOXEy7k3SYVYoE488ov5Jjkhetb01SdPo3L3ftv8Whe57aOKJSNPb+nOsjlqHCEQku13sqpymDKboNPh96sFME+XJnQpH5K39P+F4r3auMa9d0d7YiQ1Dvj7n9/wjJdZoyod8nkyeDL9XD4v3n26Qw9qpwWGrTmI0jXOyz04FOhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D08WhUtKwQHu948ULbw9LED7r4HhDb5s0MW6P71IlIw=;
 b=eJgTKaUxyxkCinzL6dfk7sYwED1M8oR1ab/SqVcQrlxUXI97AvLqI01qwTjW9z+cXRPCObT4N1f8vioxfU2uFszJoCR8YCN5c9Y7p4HL5T4ajafC4Loo47g2VyAy22EYHJogXJQLgczSGy04PlQgah4nZVN/qVgf8n0diJc3nRurH4vh12dkiwBEWglgRrKX9LzUehFIVkwLqbT2lS8KrQOG0GBT53Gi2sWGHr7rgUbSuXH4suyUChSWuJolrJMlNHM2mBhwFst3Z6oNl1C5AaLhOKrI5FGXqWyKXkWko41v8GOkUGfuLnFRJUwI7sNpmsJua3eh81UTN9kDsC4Hqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sat, 13 Jan
 2024 10:35:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Sat, 13 Jan 2024
 10:35:35 +0000
Message-ID: <56b52d4e-9dc0-400c-a141-7e70f5c72afa@siemens.com>
Date: Sat, 13 Jan 2024 11:35:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
Content-Language: en-US
To: Palmer Dabbelt <palmer@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d67fcba-61e9-4320-d481-08dc14236020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	veYrhfLBPtryCrt4F+ZAxNqqnIBSDtS3Ibg682RTGdDcXZd85ORTB+4Jk00fqnaHjuHho2YfRA0tdR0cwJz85Yj5eSaGREr6rmHP4wjNfbuIsIh2tpe+8L48QPVJVjowqxK7tRbBoh+i/ijDhyO56RgvOq3Lam9G5+juTsL9WKg0wy3Kua6A3tBpV87H/9mCG/I/aHO8c+n+/8dqJuI4pHA0k/KdQXJKAyf6jxqxUOnMMPiOn8YWjlsPms6bbB3gXSDbWQgh1iFnuHSaxMjfnhF9zzbqbh3HU1qYuQBdwTkqUfwoIJOw0V/ZFY5GeU+vPL/6TyqQEUTP/gQoQQFxnthgQhu6QAwM5qVjaR0OnYUz9bTke39Hk4b6A0sQJPIWsXGHwH4UYU+mb+NuaRLp8pFzJ+VqH6LGBqQpOpyHeTkDclKNU47IoI8zR48looxrIuzIblbEWipRYzVkYUbHBf53/+V/ccqWi1/AS0DWZPIPkDC2SjKclGxI1VuG4TjxmfIRfMDobslaVJFuoffMrhat2uXvOLk4cKLRgaO6b21KzdDRIE8Y6SZ+l/mJ+mVBloT3kXnZmW0t98tphkAh6RBZ50vrlp9D8eXlkPF0pABq02zTaTnavg8R2AsVxq5gsXrFis6bZru6idKqnDLA+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(2906002)(8936002)(8676002)(4326008)(44832011)(6506007)(6512007)(6666004)(53546011)(316002)(66556008)(110136005)(66476007)(66946007)(478600001)(6486002)(41300700001)(82960400001)(38100700002)(31696002)(86362001)(31686004)(36756003)(26005)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3dBSWlxRUpqNnl2bTNsMjBXOXBoYTdSS3BHbWNsWldJdi9sYVVTZkY4aUQ1?=
 =?utf-8?B?U3FnNGNSQ1IrV3M2bUF1VzRlcGY0azlPbmpUd2xPOGkrZ1Nyb2taekZZeDlw?=
 =?utf-8?B?cXd2UVlReURjZzdheXEzcGFjMUhFZWlqdWRvb2M2TWRoMkh5VXRlRjQyR1RJ?=
 =?utf-8?B?SGVOcGlVU2g2WXBKOXVzbE1jVS9MSjNoblFXVXMycVRyeHFmOXdsSVltb0h2?=
 =?utf-8?B?d0lBdy85MEQ1dnRWdEsrTk9CUnh6NTlXa2xhSFRSRDM2YzJURkZFM0Uyejdv?=
 =?utf-8?B?YlBpK2Fqam94M0F3SUpqQlVtc0JrTWhTQnRWVFJRczlxNEFpajhqZkhESEVZ?=
 =?utf-8?B?emJuM1ZuNmM4eFB1SUVKNTRFZnh2eDZlVHBiOWw5eWpWYUp4VTNXK1FYVkVS?=
 =?utf-8?B?WGMxalFyNnlqWVRRNlVZWXpFNzcvZ3YvN3hkY0QwWEQvc2lSZml2K2x0ODVN?=
 =?utf-8?B?MVBpZ0tvVDVpbWZ1dTR3MkVqbSt3WDh3UDJvZVRUUHdjYytSam1jZS91WVo5?=
 =?utf-8?B?WExQWFJEYzkxUzJmUVNFa3BGbWlvREk5dHJUekVvODVXR0hpZnNxTFBreXFQ?=
 =?utf-8?B?SDJ5YVpDZ1NSUjRRM3oxWW5wSGxVYUJEb3VoVEVGK1ZCTDA2Z2lWc2ZkLzUr?=
 =?utf-8?B?QWdKR0hleXg3aXZldXZCSXJ6UU5LRzUyUFZhRFdFODN4R21STFNBZmUxS0xz?=
 =?utf-8?B?a2Mxem81L0hSb2h6TVJ0V3h6b0dkNlFIVWxUR2hWS2tEeURRWlFBTG91L3hy?=
 =?utf-8?B?UEU5VitkM1Rna3BBQWczZnFWTE9ZcHNJK3hMWTRnQ3RFdzhHWFhQVkc5WXM3?=
 =?utf-8?B?eVgxWlpISXRhVW9lVGpiYk9kTHVhOHhVdDFwbHJ4WjZGOUdEVnhzUTNyTFpM?=
 =?utf-8?B?QUhDaVlvMTgxWnhxSkVCeFBLV2V6Ump2dGcwQmN1czlyNU04c2hhSitOWExv?=
 =?utf-8?B?VjZGaGFTejhSVWw1RWJzSnlzMmU2MC8wajVpU09qVTBqK1pnbzZRbEpkOHoz?=
 =?utf-8?B?L3V2RGNwbitKcG5IdlM3YkJCak5uWkFRNkNrRjFCaUlLb2xxWWNzVXZYREdN?=
 =?utf-8?B?OWVyZ2kvNDc3N2N5YkxZdGtmNG93eGcrTUVHNW5CWktFdFVNVDdNd2ZYbG1G?=
 =?utf-8?B?WjFYOW0vam4vbEtiOElwRVFRRy9kaDFwbk5zNGR6bHBOUXkvcXhPZkdMaW9t?=
 =?utf-8?B?VWFLSW95cWdveEM3MDFhNmdodFVQZFpiSTFUc0VHMk56cmVFdHlrOENHcWI3?=
 =?utf-8?B?VGFBSkU5L2ExM04xN0puV1cvWVVhRktuQnNtakw2MjVjMGdqUFJPVDdFNzNQ?=
 =?utf-8?B?Nks0bEVLTjlValVlaEJGbWZTcWdDdWUraFQ2Mnd3QmprM0puVzZWZithaVRq?=
 =?utf-8?B?aHZTeTYyN3BCdDU1S1VSb3ZDUXM5blNST0J0RGpDYWw2L0tjeUJGK3BXOFow?=
 =?utf-8?B?UVBHQmR1VG5IeDJxOW1qMGZ0VVpRdXdNZy9VNVhFTkNIRUNUSUFiOGRCRXI3?=
 =?utf-8?B?RFROL0NuNkVWbERmZ29mdXdFNUtQVDhYM3BYY2ozRk93Z1JIK3p3dDdCWWIx?=
 =?utf-8?B?OTdvOEh0L3ZFTUVnMFAzY1U1OE53Um9raVFRMFRNczIyS3NRQUJRZHNndEV3?=
 =?utf-8?B?VVdwVnNDS0RLVlc5bkpEYWRzN05wSmVZVjNrNURkT2UwOWVJNVhFaXczcVhx?=
 =?utf-8?B?OExKbDlYUnJERjVtYjJHRU4zRHo1ZE9id1hobGtXN294ZWo1aVdoZ0dxcFZ2?=
 =?utf-8?B?NGZjZ0xUNmk5UjlqT3BVUE1HeHpkLzRRUDhod25BemJEemdwY0x1bVBodXoz?=
 =?utf-8?B?Mm56RFdRd2VRSi9KQVFlc09TY0IxQ2wxZi94a3hNTnZsVVRac0ptMnMxU3RM?=
 =?utf-8?B?c29MZzdlZ0FaWE5XcTB1WTZramFIR0VNcnpER1Z6bU4wYVJUenFINGVpbUhB?=
 =?utf-8?B?bFR6U0RwVFZzb1l0d1lqdnNQZXRnd2ZSS3FLYmUzUWxGUWNuVWlxSXMycnc2?=
 =?utf-8?B?Qndwa0s0aVIzZC9NTlo4elZTM25xZ2loRzJmdjFhWkQrUzVWT2I4RDZqVUNq?=
 =?utf-8?B?UWUyaDJYenUwRTJBdEtGRGRmUWV4Y1V0eG9aWlI4eFRxTmg2NElxWFljS3ZQ?=
 =?utf-8?B?QW9XN2tVenVGYTM1dU9FZVVYS3dRT0hiNWpERjVEWU16SE9zRldLT3QwSEdI?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d67fcba-61e9-4320-d481-08dc14236020
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 10:35:35.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tc/2krXCZDILL+sFZtHsqI+vD74BzR73P5NWx+U4tLbjFYM+xsRtkVEoEtlHo1JJpTTVVjIdFhcDRrcudLAGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6250

On 12.01.24 19:56, Palmer Dabbelt wrote:
> On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
>> Hi Jan,
>>
>> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
>>> under the risk that the compiler could use GP-relative addressing. That
>>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
>>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
>>> It was not yet observed with newer versions, but that may just be luck.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Something like this should go to stable as well, but we will need
>>> rebased patches.
>>>
>>>  drivers/firmware/efi/libstub/Makefile | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/efi/libstub/Makefile
>>> b/drivers/firmware/efi/libstub/Makefile
>>> index 06964a3c130f..d561d7de46a9 100644
>>> --- a/drivers/firmware/efi/libstub/Makefile
>>> +++ b/drivers/firmware/efi/libstub/Makefile
>>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
>>> -DEFI_HAVE_STRNLEN \
>>>                                    -DEFI_HAVE_MEMCHR
>>> -DEFI_HAVE_STRRCHR \
>>>                                    -DEFI_HAVE_STRCMP -fno-builtin
>>> -fpic \
>>>                                    $(call
>>> cc-option,-mno-single-pic-base)
>>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
>>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>
>> Can we detect the presence of these references (via the relocation
>> type)? We already do something similar for ordinary absolute
>> references too.
> 
> If there's no `__global_pointer$` symbol then the linker won't make
> GP-relative relaxations (because it doesn't know where GP is).  We
> usually define that symbol in the linker script, but I'm not entierly
> sure how libstub gets its linker script...
> 

The stub seems to be linked together with the rest of the kernel, thus
the regular arch/riscv/kernel/vmlinux.lds.S is used.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


