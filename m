Return-Path: <linux-efi+bounces-4540-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3127CB21881
	for <lists+linux-efi@lfdr.de>; Tue, 12 Aug 2025 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F893A95A7
	for <lists+linux-efi@lfdr.de>; Mon, 11 Aug 2025 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741672C08B2;
	Mon, 11 Aug 2025 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VCBNEGgU"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7081862;
	Mon, 11 Aug 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951850; cv=fail; b=tJyGljnP6wUjW1R1FCKLtR5znmmLcDZtk2ObNI20elu66scY68IFgk7S3xHWmNqC4Pyrf0mAvoelLZ44w8iAlzc+mujHL3AHMNtRZ9dGmTis63+PR+9nG0VrM9qTQ/SBlKUt9z9KHWcE3lfmtLu+TdRou7oFQ0b4bOoROm41I+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951850; c=relaxed/simple;
	bh=4NAnkU9CoEUBPhPshACCe4MAACtrhJduDpfRtU1skHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ibcQ0JlPxWk+aByLuyMRZv6p89N7LCmPrgEWrEpdj5r91yGrZAMmK7mbYqbaItDpZQq4TQf+ZHBjWXBJuD4tbVZpixvaOcoccfjqAhIy4ipYIFNLrXmDiNm8lWJeTl2yZ8MCL/E8Iuf+DYTISwh4wPAkfeQeDyNNdjwPL8ZrgRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VCBNEGgU; arc=fail smtp.client-ip=40.107.244.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD4ubW7xDZh05ewFrfKTcSBljDgiU9DXw4vK0Tra9hL9ohMYGgEpX3ouMJ4TtAPPciBDitUk4hTMtT4oa8jMAZRGZqo/UB6nlDuVbQpLEoyZ2GDPOs3RZZq9ljx7J6saJ5P149IaZDRLAlv1fI7dN0eEzhLH8Pcrr9UrybC8PkpFNQAUoy4TSwsmiY2H4FEFk1W7Dw+ih471qDvptZjYrfhAkWxAL/lpe/IbDZacw2Sh9H4vXBVBO8XOlvTZSMntPyBIQboRz17s0Suo68bwSJgx9vhIuCZf2OtJ9CgCWQ91EZSLM9mSL502wjvTs9TdGPStzeqo+dFR1UM9h5ITrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD/vNvXBWyR/7raIRpUT3pi8uZpW7fXWX9ODuxByMkg=;
 b=DRPv61Srbc/mPa04w6nv5WHeLrcm25DGlYVTrDYZAn6et08uglm4axAYByHe2ydYnov+byU5+mV0U7GzRA8QayoKXkoATkTC6WkBgsSMmZApm2FV2fVVQ8Aa2hEBbNetKQs3ZMnqbJWALvkkceG92sVHhNm9izezLwf3mZ434NWMN0q0Ufcga5Hmq6vkTXWCxSMxTuxZQB2kDmGab9dVV0g/U6IMXBYWDcSbf9u//WOKB6/K2NzUVF6nlkYwgBN3N0bAi31ZC3ldxJJBTHSxUmH9TU7FUh0v08ScoqQ+q8E/mKXzt3VqKqvcv4T4zJBpjEHscYZp2EOojUgPOFN5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD/vNvXBWyR/7raIRpUT3pi8uZpW7fXWX9ODuxByMkg=;
 b=VCBNEGgUWByFx+2fKnX9IsFSn+hQR4OJUfl5f+aEJ+ZH+IWlHEfqygyhXBz6up2G6YpPf0fqMe08vIO73OVJmMBmoVul/UIx36DGTUJ567IgUvipanYW/h2IqGtoH3ebDXmwYuNNfKVYqlRqDn2SZyjCr2/36O2PuW2Dr9Av8Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 LV5PR01MB9441.prod.exchangelabs.com (2603:10b6:408:2b7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 22:37:24 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 22:37:24 +0000
Message-ID: <a302543c-7a99-4ea4-9559-e4cf4ea79b5e@os.amperecomputing.com>
Date: Mon, 11 Aug 2025 15:37:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] RAS: Report all ARM processor CPER information to
 userspace
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org,
 Jason Tian <jason@os.amperecomputing.com>,
 Shengwei Luo <luoshengwei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
 <20250805-mauro_v3-v6-16-rev2-v4-1-ea538759841c@os.amperecomputing.com>
 <20250808162209.000068f5@huawei.com> <20250809175519.74b08ea9@foz.lan>
 <20250811115238.0000272b@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250811115238.0000272b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0150.namprd15.prod.outlook.com
 (2603:10b6:930:67::9) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|LV5PR01MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ab83ab-a3de-47ac-5135-08ddd927a43e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjNMblRyUE42djdCdXZ1U0dUZmk0dWZkUEhKTWdiT250bE5Gam9YckV4aCt6?=
 =?utf-8?B?NXNZUWdIU3RXbTBBdEtrOFNqNk04MVhhd01UYzF5bXFwVmc3ZVc2RmNpLzRT?=
 =?utf-8?B?LzA4U29HTXl5b29xRStRSnRWSEg1R3RaUVFXT0YyRFhuWUtGTThkYW8rUW9M?=
 =?utf-8?B?N01haG5iYXExWHZWeWxrTWlWQ09NTGRYS3U1UEFEbWI4SEdzVC9sSDFGVFRR?=
 =?utf-8?B?VkxvK0NheGdxM0pUNTFjZnZvdGRLa0hzYzlhcXdmSUhid1ltd3JqZ1BIWitw?=
 =?utf-8?B?RmFZMlM4V0VmcWpLWFNjQis0R25YUEtYNG1QZE90dUpDUWE2bHBhSGh1UTY1?=
 =?utf-8?B?MWVBeE9nNU1zNmhqK0lOUDdQU1M2c0dheFd4cCswR09Qa2lnbXlUck5GelBv?=
 =?utf-8?B?UEhRV0w2RXVwdlFFSWRvSDRNMXZsWmp4SFRlYXdwTlZZMEFCKzRxQzlOenRS?=
 =?utf-8?B?N01KT0hnVDFBRmhXRjVrWFRyY1Zyd2V0diszYUk1RjNnQkZBVWtVQ3ZMM3JI?=
 =?utf-8?B?aG9ZZ3IyRDBURTlhSU1leUZyZ2g2R2EycmY5dERIb2JoNG1OSTNMbjNianc3?=
 =?utf-8?B?dWZkNE9HN1NPVm5RSVJ1Y2JsZW5xbHN2Znh3ZkZHOWYrdkNTWGIwcjZZTHNZ?=
 =?utf-8?B?WjBTZEhoWWdTd3hoamQ2Z0ZBZ0hPRzJpUk5YSVc5RVpWSlNxQnVBRmJKeVM2?=
 =?utf-8?B?ZU1ab2k5WjRmNXRJKzVKYXFiY1F4b0JPeVo4cFQvN0twK0JYRXcxY1EzWCtO?=
 =?utf-8?B?aDdwVGN5SUxGQm54STlsckZJWEdwMTViT3YyQm5NY0NOa1FHSzJvWFc3U0Jr?=
 =?utf-8?B?ZnVjMVA0dElnclBtNWdlVzkzSGdJeDZNdDN6MkVNdnFVYjEvdzZlL3R1T2R3?=
 =?utf-8?B?TDJ5RHBpSmFLekZOaThFUWJkVVhYa3Z4NkhTcXhrREVpd3dlYzQyZ3FLam05?=
 =?utf-8?B?TWV2Qk9Pb0tvNW5zUnVlbFNJZjFESTZnd2ZHUThZbjRzN3pISCt1QS9tdFIy?=
 =?utf-8?B?MFJla2dHNlZkTGVvUGVSR3MvWXQrR2ZSeTVGa2Y2WmxsUkFzcFdFM3VBYVFs?=
 =?utf-8?B?aTAzeW9zdytIdWxIdCtMcEdJT1Awd0N6ZlRqa1pyUTZQSm1SS01Jckw2eTMr?=
 =?utf-8?B?L2ZEZ1dZUWQ4NjdscXdrVllrRGRuN09pUFNnTE5GNTdjVnlkeWlucmNLQzI0?=
 =?utf-8?B?Rm0yWHFoZlJjejQ4OWZLY3d2U1hEOElXV0tLeDM1OWdGdk1Gd3NvSGJpTWo3?=
 =?utf-8?B?eFU1VGtiTkpOY1NrU0c1aURmSzIrVUJIaXhRdlhncTVNSllmSkc2bkhESi9i?=
 =?utf-8?B?QjE5RXB6MDdwSDRZeHA5SGFTcU94cjlHQUJna1VJWjlVMnYvL1IrNWNBQ0lH?=
 =?utf-8?B?L3Q4WDV0OG9KNUlXNkRSUUgyMVYrc0p4Y3ZZZXpIcjR6WTJqakJYdGo1Mldi?=
 =?utf-8?B?MEN4TWRkZC9BNlZhK004SDErOVJsU2dMSEpyRDNnakZ5Y2dob29ENDFsM00w?=
 =?utf-8?B?aTZYNzcxWERVYkllenRZam5UcG9QOU5JWkpiay9sejZTMGFKaFBla3VVTUVi?=
 =?utf-8?B?WFg1cXU0dlJFWnFpNmdGZnAzdExaMXphdTlUUGM2bVptYTlyNVR5OGxIa2ly?=
 =?utf-8?B?a2xTcHNITkh1UUc4SFVZa05sbFZOdFhqcU90blFUaXoyaWc3MFJCQ3lneFJ0?=
 =?utf-8?B?QmJDMkJPa09rR2xuM2NWZUtjRFc0YmQzK2VkVTBYQzZzYU1hQTRCbU9BSThU?=
 =?utf-8?B?VXlSVG9OblkxcUZzaUVvTGhEbmZKY0MzbWZuaFQrSHNoTjdwYUUxZ0FLRDNx?=
 =?utf-8?B?OElsUnh4SGV6dEJHVGozUnNaTnR3dkxEZ1JrUkdKUjhpc2F4c0Qyc0xBS1pB?=
 =?utf-8?B?QzhiVU5iVWxBSUlCejArNnU5TWZOSXVhcHFYeFlFbUpObHY5Q1hBK1czY1Yw?=
 =?utf-8?Q?Lv8ckP18QPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmZ3YkxZMFdoVHp1Vm41ZmRjYUlvd3RHaU50cnoyaG1hc1ZHdWk5Ti8xcEZz?=
 =?utf-8?B?cnE3WnRIWUhLOUppZnJYSFllM01lN21STzB5Zm5wZitJdzRYdUNmbVh1aGtn?=
 =?utf-8?B?V1VIYnFnTnBsbmZ6bHAya05vRE8zd1hJMlJhazJVQTF2Ly9xNWMvV3RReW91?=
 =?utf-8?B?QURFV05lVlRTY0s5ME05SkhtcE5YSVBIaUVIUzd1a2Y5NlRRTUU2N2JBQm5B?=
 =?utf-8?B?ZW1aSE1xQmwwcm93eHd2cjFRTUhsVk90NE9SU1IyQ1NYYklNUnJjYU5tbysv?=
 =?utf-8?B?aERDRGxBMFBEQ0d5SDBoY2V4N3JtV0JWUjV0eGY0dEVCNTNsSzZ1ZjJFT00y?=
 =?utf-8?B?WTNsMmdlRmhUQ2dEZzVyU3V4ZjBrcXQzZXdnL0N0YjlXWkVoQU1oUGc0RU1x?=
 =?utf-8?B?M0hhTnlHbHJnRTRQSkxrRDc1QTV6N2NGSmp6cnBZQXp3U2xXSVQ1N082TFh3?=
 =?utf-8?B?Q1NCYkZQVkh0anZLVlIvVzFEeDhUcVlWSVNvd0lybm81bUJFRlN1YjJHN0RU?=
 =?utf-8?B?VXlmYk9ITzRkWEhBNG1QbGxKZk9wSEJ6cmpzdFFmWkxtWk9UY1JNNVBmUVZs?=
 =?utf-8?B?WTIwcDZNTE53QjE5L3hiVTQ1aDNadVFpT29aZjhhaHdJQUw3eG5PRkNZdGVX?=
 =?utf-8?B?cUpCSUVOSzgyS3hCdjVJZ1Z5RDM3aXR5cFE4TFJNaWFidUZoZ2xQdTZ3b3N2?=
 =?utf-8?B?M2V6cHVsKzZka0c5dWJYdGRmK2ZuZVZ5M2JBdHJlQi85NU1zWHNjdGRhQjBl?=
 =?utf-8?B?WWMyaHpDN1FCU29leWhEcVlTRGdQZTE5ZzNHZEN3TFJBczcwMVFPRVpmRjFH?=
 =?utf-8?B?TFU3TVdQK0RIRVQ1YTNVRWluUmd3SFpzNUU5dnA1QnE4UzhZMUQzVkxIam1P?=
 =?utf-8?B?RzNQd2pXRkFFWkNiSnFhNFc1ZEM4SU1QMk9TMCtieG9pRElCOUlHTUg1eGk1?=
 =?utf-8?B?Y2o3NXNMcFRHYWpYVVR3dzlsL0FacWhmRFJva0Z1cHdTZ0Z6SEQxcU5SR3lU?=
 =?utf-8?B?R2Y5Q3JvYXVOU0tTRys2ZUpMV0hJVW8rRTVncmppSzllbm5ib0VaTUxSNmwy?=
 =?utf-8?B?Yjd1SlVEejdlZDFUNXR4NkIyOWNYZnFia3RLNFlsVlVPS3dNNnNSQndYaHNQ?=
 =?utf-8?B?TUxrd3FjR21STWxYZ1NLMFZzSHIyZDRlSmFiZ05BeCtmZDV1M2VDTU8rQXZM?=
 =?utf-8?B?Y2FBa002WGZkWFpzc3U4emMvbFM5VGJhdTA2cUFid1huejBYd08wTDZSUG1B?=
 =?utf-8?B?eVh0RUpSNTJHbVZ5ZU9IS0loMkt4MWVWaDJsMkZ1VjVOZ0hNbnppcVhEZmty?=
 =?utf-8?B?eVJpR1hnSWM5K1lMTTNKU0lGcCthM0lXZk9LTlRFV29MMHR3OFgwSnQ3b0VO?=
 =?utf-8?B?YjdHb2tPTE5ITmxxeWdSNXVPTWFwN0dIUmorMEZQamsyN3ZWTm1jeGFFbzQx?=
 =?utf-8?B?aTNSS2Vvb2NXN29OcWlPb0tmUUYzSGtMaXdJeEt4aXEwaG1DRVdTdkFDRWgz?=
 =?utf-8?B?REdaVEh6bDhibFNyQVZUVTRwYmtXZ29kWkh2NUVuWlA2UjhvYXpSN2hObDZv?=
 =?utf-8?B?M0Nqb2NvcitiWHRZQzRxQ09BYms0MkhseE9VVVI3U1d2THBRdWhMeFdqVjhV?=
 =?utf-8?B?ZGJYZXZROXVtdy82ZFllR3g4Qkpnc1QveDdkbjJCU0k0MW54ZEdaTVVmdVpn?=
 =?utf-8?B?S0djdUVvKzVkU0N4MW1VblRyWGJnZWpGdEhBRVVKYXNud3dLYXpMNjFTY0Vq?=
 =?utf-8?B?RzdTZEFCVDhhaUlQOXhiNDNKMHk0N2hpS3Q3enEyeVU5Vk13Y1FCQThKVEFE?=
 =?utf-8?B?Tno1VWkwRC9WT21wZlBtbFJ5Z1pieU0vK2xJUTRGNGs3TVR4YVFHNHFMQ1d5?=
 =?utf-8?B?VWFiUlJpbzluVEdzakhlalc0NzVURTM5Kzg5MFJKTi9PZkNCbkh5VndiQWx2?=
 =?utf-8?B?NjVSdHVETnpZOGdYdHljQUdBcE9kV2ljWE1PMStRR0hpK1k5dzdSamJNM2xo?=
 =?utf-8?B?aStpbjBnV1pKKzdqWVhMOG9MVUpHdkwxU2JJWGhFSUVTM2FhVGpWUVorS29a?=
 =?utf-8?B?WFppVHdkbXQ2MzU2bGtwV1FWNitmaUZ2bWF2TTNuYUxKOUg0WWRpaFVvS0Vo?=
 =?utf-8?B?b1Fwdks4YTNiVGJ3TDVzQmxkeUlGQzRWWURLOElwMW01emRtWElpL0VrelBt?=
 =?utf-8?Q?b6hiRb5GMsjHYTSugPkQIVM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ab83ab-a3de-47ac-5135-08ddd927a43e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 22:37:24.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f3Ti5OOqpu0ajBVANfp5CRKHx2ypGTU+myNT5gholZDhgT79FdEl70xE1T6rt4rQwlr4a+WoSPwDabL2+Kl7u+EukkUbxLFmC+95eUOgX9/vMrRLUjzx+rAclpFZ7Qi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR01MB9441



On 8/11/2025 3:52 AM, Jonathan Cameron wrote:
> On Sat, 9 Aug 2025 17:55:19 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
>> Em Fri, 8 Aug 2025 16:22:09 +0100
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
>>
>>> On Tue, 05 Aug 2025 11:35:38 -0700
>>> Daniel Ferguson <danielf@os.amperecomputing.com> wrote:
>>>   
>>>> From: Jason Tian <jason@os.amperecomputing.com>
>>>>
>>>> The ARM processor CPER record was added in UEFI v2.6 and remained
>>>> unchanged up to v2.10.
>>>>
>>>> Yet, the original arm_event trace code added by
>>>>
>>>>   e9279e83ad1f ("trace, ras: add ARM processor error trace event")
>>>>
>>>> is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
>>>> exporting any information from tables N.17 to N.29 of the record.
>>>>
>>>> This is not enough for the user to be able to figure out what has
>>>> exactly happened or to take appropriate action.
>>>>
>>>> According to the UEFI v2.9 specification chapter N2.4.4, the ARM
>>>> processor error section includes:
>>>>
>>>> - several (ERR_INFO_NUM) ARM processor error information structures
>>>>   (Tables N.17 to N.20);
>>>> - several (CONTEXT_INFO_NUM) ARM processor context information
>>>>   structures (Tables N.21 to N.29);
>>>> - several vendor specific error information structures. The
>>>>   size is given by Section Length minus the size of the other
>>>>   fields.
>>>>
>>>> In addition, it also exports two fields that are parsed by the GHES
>>>> driver when firmware reports it, e.g.:
>>>>
>>>> - error severity
>>>> - CPU logical index
>>>>
>>>> Report all of these information to userspace via a the ARM tracepoint so
>>>> that userspace can properly record the error and take decisions related
>>>> to CPU core isolation according to error severity and other info.
>>>>
>>>> The updated ARM trace event now contains the following fields:
>>>>
>>>> ======================================  =============================
>>>> UEFI field on table N.16                ARM Processor trace fields
>>>> ======================================  =============================
>>>> Validation                              handled when filling data for
>>>>                                         affinity MPIDR and running
>>>>                                         state.
>>>> ERR_INFO_NUM                            pei_len
>>>> CONTEXT_INFO_NUM                        ctx_len
>>>> Section Length                          indirectly reported by
>>>>                                         pei_len, ctx_len and oem_len
>>>> Error affinity level                    affinity
>>>> MPIDR_EL1                               mpidr
>>>> MIDR_EL1                                midr
>>>> Running State                           running_state
>>>> PSCI State                              psci_state
>>>> Processor Error Information Structure   pei_err - count at pei_len
>>>> Processor Context                       ctx_err- count at ctx_len
>>>> Vendor Specific Error Info              oem - count at oem_len
>>>> ======================================  =============================
>>>>
>>>> It should be noted that decoding of tables N.17 to N.29, if needed, will
>>>> be handled in userspace. That gives more flexibility, as there won't be
>>>> any need to flood the kernel with micro-architecture specific error
>>>> decoding.
>>>>
>>>> Also, decoding the other fields require a complex logic, and should be
>>>> done for each of the several values inside the record field.  So, let
>>>> userspace daemons like rasdaemon decode them, parsing such tables and
>>>> having vendor-specific micro-architecture-specific decoders.
>>>>
>>>>   [mchehab: modified description, solved merge conflicts and fixed coding style]
>>>>
>>>> Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
>>>>     
>>>
>>> Fixes tag is part of the main tag block so no blank line here.
>>> There are at least some scripts running on the kernel tree that trip
>>> up on this (and one that moans at the submitter ;)
>>>
>>> I'd also add something to explain the SoB sequence for the curious.
>>>   
>>>> Co-developed-by: Jason Tian <jason@os.amperecomputing.com>    
>>>
>>> Jason's the Author, so shouldn't have a Co-dev tag.
>>> There is some info on this in
>>> https://docs.kernel.org/process/submitting-patches.html  
>>
>> My understanding is that all co-authors shall have co-developed-by
>> and SoB. Anyway, doesn't matter much in practice, I guess.
> 
> Nope.  In the description the docs say "in addition to the author
> attribute in the From: tag"  There are also examples where there
> isn't a Co-dev for the From author including the subtle question of
> ordering if someone else posts that patch.
> 
> I have a vague recollection one of the scripts checking linux-next
> might moan about this. 
> 
>>
>>>   
>>>> Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
>>>> Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
>>>> Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
>>>> Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
>>>> Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>    
>>>
>>> As person submitting I'd normally expect your SoB last.
>>>   
>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
>>>
>>> I guess this is because Mauro posted an earlier version in which
>>> case this is arguably correct, but likely to confuse.
>>> For cases like this I add comments.  
>>
>> If the patch is identical, and it is just a resubmission,
>> I would keep the original order.
>>
>> Otherwise, if Daniel did some changes at the code (except for a
>> trivial rebase stuff), better to move his co-developed-by/SoB to
>> the end, eventually adding:
>>
>> [Daniel: <did something>] before the custody chain block.
> 
> Docs are clear that sender of the patch must be last SoB.
> That's also checked by the some of the tag block check scripts
> I think.  There's an example of exactly this case in the in the
> submitting-patches.rst file (last one in the section that talks
> about Co-developed-by.
> 
> For meaning I don't care that much, but keeping to the rigid
> rules in that doc makes it easier for scripts to check for the
> more important stuff like whether all necessary SoB are there.
> 
> Jonathan
> 

Just to make sure I get this right...

I will move my SoB and my Co-developed-by after any other SoB's in the tag
block. As a result, I do not need to provide an explanation in this case,
because there is nothing curious remaining ? Or should I still add comments
indicating why I rearranged the tag block ?

Based on your feedback, I'm intending to organize the tag block to look like this:

 Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
 Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
 Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
 Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
 Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
 Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
 Tested-by: Shiju Jose <shiju.jose@huawei.com>
 Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
 Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
 Link:
https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section


Is that satisfactory?

Thank you,
Daniel

>>
>> Thanks,
>> Mauro
>>
> 


