Return-Path: <linux-efi+bounces-1192-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E869F9028AE
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 20:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AE91F21DA0
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D414601E;
	Mon, 10 Jun 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5sl1H/xU"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A526AF6;
	Mon, 10 Jun 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044305; cv=fail; b=h4e8ks3S46qu3bzH2MJzyOnx7A0KpPsql6B9OwlQOVebTB+84Nfpt4DBxXDwT7LI/vjV2jcijCu2uOPCRzXCJb+j61KSD+75S98rCoFU3bpzUokZDpTe93IkskyAAhLaX5iTpySfKW+otana+nYku9wwXXuNsIr4LeUdpdGChxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044305; c=relaxed/simple;
	bh=Y0sY16EvmJstbZ5GGyptTSDbGkwCL9zI5CZPUTI595w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=r8M29GaXuYBNEhQO+/CdEKVnJ+1raestjPWzzADFLQLdoNC491S2BoL+aK3Ts1ikwv1QTRve2Lui/1D0yTX/wV8c/Gh8MJTtR1cvHLlOSZtSDoKImYkBcHggw0QSsEk+tTKyWXm4fFHYIjlYoU1MVr/Afi3p0lOOsTlgST2l50E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5sl1H/xU; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLi5UJ75WkUv4VqJRAf+R37gDzxVCmlXIAFWpPg9KY5KvkY8UEY795WUbDdSx4e/qdivjNoSdXBvfP8/3WjzDErGyArsNDqC1IbSzvKbzV7ha9adP613a/eVV9Wc0oni+fqyiOnViGLscHYYpTpfZ9tJBofABbm5BhbFoHNDK5i9jSqOgd/FaRDGLhvg3MtQh9A3BQmhmkHIYkK3clAc6Ikwf3O85qi/CuidQE8Ml7N01eVVdFOC/pzeHjKOwFzAlmBtFVoE/9/ybLYf+hUFW+nfEUEsKuRtJzQhvqZsN3oLiq9Ov+3AKZg9MB7EFkLxcgRLl63hXt8QZQP94pEMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOOPrGle2e+ieDk9ZQ84UpMQIv5lshTY0XQmAYxt+9o=;
 b=XtWkX8Sk0pbFDUPOcklPldzxaVzSrAuPbyi57a3/cEim81ASdvTArGIDaLs8zt+bmRgwbNEdCwP85YLiyPTjcQQRbljplVrgN/iQ46vDQ6PpDq4I1kMgV5mdCpf4Z7p8Wo0D035VDjNNBHYdf3R2MJQPm1RI8OyDx95TqGhcaIudtVuboUn/EFIb5b13df1YTwVQ4OMfQ/m513foY+1aorch8PUH6sUHnDU2lV16FPYKFAw0Dxr/OP34dCZOnbSaVO05fijWCYgWcVDx7No+0Y1TieVj5lrjTuC2iWg+gNY2AP5z85EA2jwzhxcTBq93I/eU90Es1b/YGtdZCXfuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOOPrGle2e+ieDk9ZQ84UpMQIv5lshTY0XQmAYxt+9o=;
 b=5sl1H/xU/rSYBnqtFS83p1PcrNEIWb3rTA5uH/oQLXmn6AQB4H5cX82EDpXzPMt0D+uxt38J8l13o7iMZ2CwTGH0DdIh5dOm0enJSJ0FhnLX/xlB+2FKX3ZAkT0tDxtuq0tpuUV78b0vj/4xTj/ENcZD1t1JmzeLCXyoHfpmgVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 18:31:41 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 18:31:41 +0000
Subject: Re: [PATCH 1/4] efi/cper, cxl: Make definitions and structures global
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-2-Smita.KoralahalliChannabasappa@amd.com>
 <20240607161439.0000030c@Huawei.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <6ca8d9e8-cbb3-7721-9295-970ffa1a89d5@amd.com>
Date: Mon, 10 Jun 2024 11:31:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240607161439.0000030c@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 70602582-386c-4622-3f0d-08dc897b9249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnZnOE1Ccm15U0k2T2pvZkNXYjhiZmJDUFlGU1ZTMWg0L0hBZmhGbUhHK0lo?=
 =?utf-8?B?OXp2Y0E3WjBJUDZNaXlWZjdMVGJmVkZKeCtIMlZDaDRoenl3eWxOM0pDRld6?=
 =?utf-8?B?Rm1sQ0c4WHB5M2N2dzhXSUxNOEl3Wnh5ZjRXdFhPaU1uT1J5dEdBT0R3ZlE1?=
 =?utf-8?B?akx5N0kxYkRIc2RWMm5leGM3Ky9seUltNWUwT0U5UEwxbU9VOGg5aXA2SktF?=
 =?utf-8?B?a1BPcEtIRk5uUHR6KzVmeVlWYjhRdTUrR3V5U2MrakM0akEzZVhKZUppQUtN?=
 =?utf-8?B?eXkrSVJnZEt1QUtzK2dVY2o1Y3hvRzBaNW84cG5PU1pyc01QN3BqZmVpZjF1?=
 =?utf-8?B?VFFDVzNjMnQwS1BuWE9vRU1TZG1KeFJISGV4TFJhck5XTDdFS3JZQStmc2kv?=
 =?utf-8?B?RUp6SVJCZTN4SzZQQlhVcHQ1NklnNUxHRHIvM0haOXZmdDEzYVJnRFoxdXM3?=
 =?utf-8?B?YnRTWjk5SDVNbG8yQ1pnOGNhVy91aFFOYmQwWTJpYmRIQmQvSXhINzloRktE?=
 =?utf-8?B?V2dEM3R6cWNjTEM3M1F5eXEwcnhyQytLd0FIR3JVb2h3dmtYU2JJYU8vbWt1?=
 =?utf-8?B?clpmcDBSejd6MGc2dkhSMHdqenhKeTdxVGFTV0JvTXl0eWVESllZcjFPTWZ3?=
 =?utf-8?B?cktia1kwOXQ2dXVGUTFkK2pkUkY1cTFvWnFaMzBBOElWWEdxbVJsM0M3SkV4?=
 =?utf-8?B?c091Y29rWUJIb0tMNEtvRVEyYytMSmpkSFpHeFFzNHRpSWtnQi9xMkZiSXda?=
 =?utf-8?B?b09DdEFjS0R0SzJTRWdYRmVRdWNrREY4M3ZzSXNlZG1sZFJNRzl1SHZtMGJt?=
 =?utf-8?B?M2kwaXlYTy9Idm9VUkVGbVM4TXJLdWpEeU1ZL0t0enk5Y04wV0w1ajRSdnBJ?=
 =?utf-8?B?Q3hHZzE3a1l5cU9EQVg2djBPNlg4MVVCYUtrRHVBS0ZqQTJUNFdLRDFpVjhD?=
 =?utf-8?B?bm1DMlFtZ0wyWGROSXkxMjZOdXk4Q0xRZ1FxUGd2NzlrUDc5RTNXdjIxOXlK?=
 =?utf-8?B?OFNlVnd2RXk5WXhlK2pPUlRZQkJic3BQckRCbUZwdTJBOUFrUk1ON2hacUlT?=
 =?utf-8?B?aVdDeWZoVlhMM3FzZnMvZVQ4Q08rZVRYeVhjajd2dXpBclBsY3AxY3paQ3U2?=
 =?utf-8?B?dmtzN1gxRE1zWUQweFRaY05rMFBkdERGalN5cU9oSzFsMTVkcUdtZ205c0tN?=
 =?utf-8?B?TFJyampMZ0hQL2dGcGhFdURQb3hXS3A2T2tQZzBwZkNXcnpEWks4YUUzaFpJ?=
 =?utf-8?B?TzFKMm9ZSjQ1WC84akFDWDdkWTZGV2xTbGtXbGR5VzErci9CRkI5VHF0M2Fy?=
 =?utf-8?B?OWVqSXZ3dlkwZGN1V0RsWEc2WmpIQlZIbStIbzFJcFNBZjJtNG00L3FZT1I2?=
 =?utf-8?B?c0VMekhDUldqTkhTekxUQXU1VmlIQWZvZ2tqbDNFWDBPenlzU1RMK1NEWXFh?=
 =?utf-8?B?Wlg3SUdmL0d2UTJXSTV1UjZ5Q0M5RmZnR3pHdjJiUE50dDVhUWk4bGUxYUdN?=
 =?utf-8?B?UXA2YlR2Y0xJMll5RmhHREpWQ2UrUk1Id2ZuYWxDdXZKNlhFcFRKYWdFNXJy?=
 =?utf-8?B?RWY1ZVZ1cTNmaUw3UkpEOWUxTU5KU2VUTGhoc1dMQXZIa29ZTXhlUHVFWjBR?=
 =?utf-8?B?dm9JNC8weEZ2K1I4bWZaVlB0TEdwc2dwRVVpNnBjdlVCcEkzVlNaeUJaODR1?=
 =?utf-8?B?V2tvcXQweXM4VGZadnZqNjMvSm9zL3N3N3hnT1Vrc2FVeHRYZStNa24zNUZZ?=
 =?utf-8?Q?83bfrL0WN4DWpVPYnkrRIzS9QNPSDU/MDVIHE/2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUhzdHFqYUpITDRVQWhKcThSOGZZYzhFdEwyRlB3RnB5QmtyWWg0N0NXMWdS?=
 =?utf-8?B?VEpodmg1SDdmalA3YWYvSVpwT3dyd3I0Q0p3ZlM2enNVVkFZTVQ0VWlaM0gy?=
 =?utf-8?B?bzZOVDgrS0NaRjhrM2ZXWFVQeVA2NkJnUi82akhpK1k3Yi9FVUFMZHVuK0pM?=
 =?utf-8?B?K1NxNmpjVSs2V01LeEF4ZUpBSnF5M3JoNFgvVXpqZ3BQM1RYTThDWS9BYkh6?=
 =?utf-8?B?M28zWTBhY0RMV0tsVTgvQzVSRlVKU2QyT281cDNiVWdyWEVDSTJrdHlrYVI3?=
 =?utf-8?B?TGd4MXhDSGxEMHhHRW1rVnRSbUtUR3pXVjlCSmZzeFFTOUVudVp0TlJjVEpT?=
 =?utf-8?B?ODUxK2NqYzFrTWZxdkM0c1NZWFJnUmNMNTNWejYwMGQzaUdwV3hIZU53S0ts?=
 =?utf-8?B?dGtpN3ROeUhUeW1EQnN6dVBTUGxmY21nclRWSHh1Ukt1NUNPcW5NNWV5dDlm?=
 =?utf-8?B?ME5EQUJadUlQSzNUb2hqbGFta2lQTEVJbEdDRFJ0dGFRQXF5a0dya0NsQmht?=
 =?utf-8?B?Mk56M1NxRmNsOWM2RjREeHB2YVRMbFNWNnF5ck1DWkptaVhSMS9Yd1ZKYld4?=
 =?utf-8?B?U2dmVlFKZ3ZSZ2NucEZPSExOM3NkbUpOTnI0Njg1WmZLT2w3NEdwWG9NWERE?=
 =?utf-8?B?dFpIK2RETEhrNFEweXB6RVp0Y1lBSEdGazNRSWNaK3NqQlZVWklLRU1icjhh?=
 =?utf-8?B?S3lDTC9XNE11NWRwV1A1U0NlT0NUSDAyeWEyQWxPdjJCYkhVcldIV2RtY2hv?=
 =?utf-8?B?N0x4TjhRL1VpTUs4TmV1RmYxZWxUVVMwSlFNeloxSUJVWTkreTlNRkNNeW04?=
 =?utf-8?B?SDh1aTh3QnlYaTR2V2R2MmJWRVZhalFGWjRPb3AvRS93N0MrSithSnMrQm1M?=
 =?utf-8?B?TklGbkorNkt0ZDdpMThjRWdBckZUVXlxQlZpSWxoY25zUm5ndjRBTjU2anl6?=
 =?utf-8?B?MXF3aElQZmx6RkwrK1RqOSt6SmZyc3pLV3oxY1hLcjFvT2pLU3l1ZlJ2alNK?=
 =?utf-8?B?Zzhnck1LVEphbVkwY29lN1pxdSs2bEZ5bmZRVVNOMGRzem1aMjB2ejBuYVk4?=
 =?utf-8?B?ejdTTlJNajZ4OFQweWYyMHp1M24vWGJmck5qNXBCeEQ4QjN3ajI2a3Bqd2ht?=
 =?utf-8?B?Z1pDMXFTdlJTYkE0cEVDbE5RL0ZlS2VLOEVLaS9EUXdTTHpWUS9qSEFnTGJ3?=
 =?utf-8?B?Zi9rTk00K1FhSE40UTV2WnBpOEw5WTRObk1zTHR0bFNpZ1JPRTI1NUpNaHcw?=
 =?utf-8?B?ZTY2dmd5WkhrZ2N4RitWNzlZOThJUmtTejd2b2tHa1NxdkFUSkNMK0tvS0NX?=
 =?utf-8?B?OWpqcDEyUEsyVEo2V2E0RXhsVEUvRE01emlWSFRNYjBseWx3OSt4OTA3VGo3?=
 =?utf-8?B?ZFNndVQ0US9XRmE2MnlCMGEyQUNlWk1HVVBmVmFTQ0QycjE0RCtuM3VyYkNP?=
 =?utf-8?B?dlg0WGg4Ykh5LytERlh6UERqUFV4OC9ucUxaZ0RpWnFiazk3V1VQUDZHN1Fn?=
 =?utf-8?B?ZDNuZStHKzB1RFg5THdlaEkwWTAvVjBSNy9FRnRyUzliNTFHdjJFc0lVZG50?=
 =?utf-8?B?VU14c1RENndtV0p4eXhpQTBtVzgxY2pwM0wzeUpSVlIydWo5N1RYNDhaeUND?=
 =?utf-8?B?UE5SdS9Wd0ZSU1lpbFoyT2NqSmF1cVl5LzMwYzZIUlN5Zk9oMUdtSVlnbXNQ?=
 =?utf-8?B?SDB4eUUyMmdneGQ2WUZEcG0wNFN2OWhYK0NpQXdhZUNtbyt6M3JFOTFraFd1?=
 =?utf-8?B?alR1b1dxR2owbklpWFAzSDJDeFJhMWgvSGNDdTZkZjVxYnlQcldXT2ZsUTBS?=
 =?utf-8?B?eFk2cGg0cTBudU8vdFFmWVZ6Z1VuMldCUlRIazN4T0hCTXVnRStPVDBDYnMy?=
 =?utf-8?B?TjhHWDJyOERBVXMxNjZzbzZoSEx6UG5HbGZSY2hLcWprZmYxMDUvS2lDKzhC?=
 =?utf-8?B?WGRDRlQ3YkJ3SWFyek5KYkV6NmlBZitObkZjeVNzbG0zUlpINk1xNEhGUmpV?=
 =?utf-8?B?d2RDaDE4R2luVHQya0JpcUkxdHdsOHF6cGdoQ1ZkTGRKejRobVhxWDRZdi96?=
 =?utf-8?B?OVB0ckQxR1oraVI2VTkvVUo2b3hoNkRTODhPM0VMTStjSE4zc3BkM3NWRXR5?=
 =?utf-8?Q?sN9K9HzAxiASX7bJiNys0oV8P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70602582-386c-4622-3f0d-08dc897b9249
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 18:31:40.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ0SRMOhz/HL/cJfT0MZQUMEW0PAz/p/sJsqWi2yOvkN9roahneFpFmyLq0BiciM+ELn9wHx1vR1ECk9IBbADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

On 6/7/2024 8:14 AM, Jonathan Cameron wrote:
> On Wed, 22 May 2024 15:08:36 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> In preparation to add tracepoint support, move protocol error UUID
>> definition to a common location and make CXL RAS capability struct
>> global for use across different modules.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> FWIW given already well reviewed.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Sorry I missed your reviewed by tag. Thanks for reviewing my patches!

Thanks
Smita

