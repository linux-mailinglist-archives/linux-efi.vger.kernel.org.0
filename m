Return-Path: <linux-efi+bounces-1899-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232D98F6E2
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 21:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B43C1F21C0F
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9C1A7043;
	Thu,  3 Oct 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5gCooChQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617011A4F34;
	Thu,  3 Oct 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982937; cv=fail; b=opb9EHegq+8XVSS4uBa2VoVbtQaTC4tV51Rk3DzTxzMPOLgYf/P92v3nzC9p/4CHTIHcxiBxBYLu/XIG5Iea8+DpxN1ebX5K62fJ4wlohmpKNH8Qz4cno/D4FKyz7O7lIYJwOiix9DcsFY4cK3DVSM0il7nS6cJTmzR+3qjvOIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982937; c=relaxed/simple;
	bh=oi1O77oLKFRq9c1R1GqrCCfRCzkPpX97x8O+wjF/3b0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=LeLOSWJUwxmUYVw5omA2okxec94zdgoFwzVV+abz8RjwYGoVSUDYIEdcS4TWvELWrW0QYdK2IRPzcY7+9wqD42wN9d4Uhr2UiHHAsxIsAtAKeNw5bFxu4wNggcE24hnM83Rxnl/ehkT4RIGhh0CqhsRWYB9LUnDeX4l9zzzwoy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5gCooChQ; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMLZuCPtHM9mmFXWILfQuS+GYrbGRLIH01HZpkSQPwo98djj9P5zRrvvO3Z1qcWGWkaGsi5gMiQfo7xs3GOnWFnMpE2F7Va3SFbHW5Ung/cvwg1U3+FOXz1dMI1H/oGdFJmY20He+2T9asWf/ADHLTQNyXkopwOVA3xvAv0WE7tN8XK3KCNeO0AcPVfzjrKuwJ058C2i/p33kXvNcRVLan9hGAnHUbodq3+1UcvptqyNAspGnGLMFlTmofmKhY4iN32HkKbx7SGz/Cih5PZvm6eMvG1RUmyFPi821sh4QWR0KvS+CHMewgnmPqCWUvX7K21doT82K7nTO7F8XQL92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89kCaTwzFAB5fCCmVXyArngH4VSk6ftQdnq3coh9m0E=;
 b=b220GfjuE1apYkYOXW+5HQtK2FQft3UWfmwt9yE+puQ5qbir9V5kev13x0HTYpMpGH0gXykQubZ/V1MIdGPMTsJn0jBnpGYIEC0JgsRsyCkvDHRReTFiozH8o8EKPqZthDdqmutTae+WCbbi4trXFxpQbBgDZDhf8pg8+1xOwaTv4YgRHxYmtmPqAo2MSw7BPYN6eNvMp7vuoz1wGCRM/MTm/FV04aNJ7TMLRFT17KaI4zIps2cdM/TY5gpy0VBhKIUCTCakZjtXMGAg0p82VeiRCkwHM6PA3Fu9x/E3u/HxV155phABWATBjc0HRaNNxihvwZlWhO4b1FzPg+aazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89kCaTwzFAB5fCCmVXyArngH4VSk6ftQdnq3coh9m0E=;
 b=5gCooChQymctHIHdgKwTJ7yQbEp37vIZlOs4cvCUXzgVcmZ1oz3MXtbXsQy6lzGpWtYSP/RiWvtHDaPfjMwcK4viThIQMgTUU29UIeA6S8nTRvrwnI+FdVxub7hRDVop0IqBNufuGpj7T3QOneCj+l1tdeJFkBPgJcSNtLpvoKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 19:15:30 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 19:15:28 +0000
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
 <66fddbaf9acbc_964f22942e@dwillia2-xfh.jf.intel.com.notmuch>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <082e7c7e-9306-2f99-3693-696350cfc43f@amd.com>
Date: Thu, 3 Oct 2024 12:15:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <66fddbaf9acbc_964f22942e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::44) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 58513b72-bfed-4977-c029-08dce3dfbdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1VDSTlUSmFoei9aNXllMzZ0c05jTVNZRjQzTTZOclhROEdVWFdyOSszYzN5?=
 =?utf-8?B?WUF3djg3U1lRa1djMzVEdDlLUWFMNDRpcVV4MDhwNzRrZnU0dnByUVEvL0Zt?=
 =?utf-8?B?WjNIcDFRSnNtWmFFSlMxbUNEZTR4czdIdG8rVElOL3hnODRpZlVKV21TNHBR?=
 =?utf-8?B?OHUycU9qd1FsclA3elZBSHZWUXZMcUdyaXVzVUUxMmVJRXN5RWxaTXZQTnhk?=
 =?utf-8?B?ZnNzUk9mb1FTYkludWx1WmMvKzYxZXRiUndCaWFuc1Y3blFRdmlPQTYxUFND?=
 =?utf-8?B?MTVtMHZCMmNrczNkY0NhY1czTzIyTmJ3Um05V3ZMWnpnVUpwalRKNzBmNFhu?=
 =?utf-8?B?RVBtbWl5YTRRa05DODRrSHhrS0QxcHg4VTdUY2c1NGpZaTVvcXIyNVVJMmpI?=
 =?utf-8?B?Wmp4ZUV1YmdGa3Nhd21MMXdtOGd5U2E2Yk9ScVJBTUoyMG1WNXgyRER5T2xi?=
 =?utf-8?B?eXVja1ROYjJsQ2FSa2F1QnpWK0ZKQTNRbHlvQUlER3pBREhIMkUyaVNuYWly?=
 =?utf-8?B?UDE5T1BNWjhXdXNRMysxdDBYRWt4aWxvQmp5UGluUHdOM1ZFQk1kYzdmWUF4?=
 =?utf-8?B?c2RYNDMzb3RudUQrd1ZZNWgwVlNka01PanJvVll0MExKRlRzTzNTU2FJU0pC?=
 =?utf-8?B?VU16eXF2NS9TdWNYUEVPQlpuUDBHeHN5U2hNSGtnTFVDU1Y4emIyT1BhUjBv?=
 =?utf-8?B?UUlaVmRTYmxQbk1jYWVFazhCaXBxV1R4MEsxYzRSelRPK2R3NlZYeVZmaytV?=
 =?utf-8?B?b24vbUQ1U0tSbDVIWUhCMTlqZm1TeFkrcFdGY1Zhb0IzNUkyczhGcm1hQmg5?=
 =?utf-8?B?U3NYNkZZVk9UVXdJVmVmcE9mQ0ZHRnpNZW1tbkF2a2VyTEhlV09VWWlneEZY?=
 =?utf-8?B?K3Q1d0lpYzB5NEt0cis3K29weHJnVXFHQTRqS2tkYm8wcm5ScTMzUUVFcGNx?=
 =?utf-8?B?MGVwcEdMckJkVFBxdlkrazdHbnZtM0hMSGc4cC9wd1I1K0xiVDNVb1h6eE5J?=
 =?utf-8?B?eFVsUFlseCtIcS9oOUdyeGtjdHA1ek9QMDEzbm90Zi9hQmpRMkVvb2lhQXZW?=
 =?utf-8?B?WVRvRUhQeXJIT3N1U1ExQkdoT3dqdDhxa1gyZnVGMEtDYUZLVjVPclpIdS93?=
 =?utf-8?B?OUkvNWJvUW9EUWt1ak4xWklCUWdLMmdKWGE3aUluVTl3cE1iUU9FMHVjZVdh?=
 =?utf-8?B?NVpyS254Yk56ekVlbkN2allBemRMOFJTRDBnTFdHems1YTNCaExvaWNNRWJM?=
 =?utf-8?B?dkJKTjNYM1lYaWFhZk9qQSt6VUdGVmFyWllpSUp5K01vWWh6K2ZwZUVhSmhI?=
 =?utf-8?B?T0xrVEFqanRFaGUzTVBSVE12c0RYQXN4bkRQNnhoUGlyZGhBQ1d0RWhGRGk5?=
 =?utf-8?B?eTJCOXdZQy8xOFhxZTJlMTJpUHhxYjFlaEJwVDN5N2cxenhnRHBVSUZEUGdq?=
 =?utf-8?B?aUlkaUtRRjV4cDN0VzQyZ3VadmpFZng3eEc5anRKMVJ3TkF0TkpSbmd4dmJm?=
 =?utf-8?B?WElNS0ZOZEtnazdNNU9WWkd4aWxMZVY3WnB2STBESVdHaW1HZG1ERFE3dFVK?=
 =?utf-8?B?N3pMNGJLYjBkc3dmNEZBWGdqV0FPd0tHeXpvblBkbGszREZTZDM5aEl3dUJp?=
 =?utf-8?B?U0sxaWdGV2RxS1FBSlZsOW9hSUNhQk9tZWFoUkZxQzhqU0dObXQyOEFYNjFR?=
 =?utf-8?B?NEhVMVRaOUV2b1cwZytZSE5qajhRVjN3OWp1d1dpZ1pDZHc2TXFyblh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFl3TmxuYWtnZWdCcUhMbithZG1ncndCbzVIYWk1MjhCcTBEM0xmeW9vcjVo?=
 =?utf-8?B?K3JCdzFYYTZKNlliVXJwek5FRzNTR3lkNGlwYXNnMWhCd3A2MGhHa0FSMHpX?=
 =?utf-8?B?aFhCTEJqMW5wclFsU0hVb3I5UkNEL0VIWTh2QzJYWXpzMXlHZWplYTlubFhr?=
 =?utf-8?B?Qm1rdytxWHJ5VzNlaUcvYW9qaUhKUFdZdkdrL3NTTmFiMTdPaEl0M3dMNmV5?=
 =?utf-8?B?Rk5UR1Y5ZXgyL1dXSkRxbEI4RHZrd0JhMzBoQk1yeEtEMlkrMzFYNkpqT0w1?=
 =?utf-8?B?aHBGTEZzWHZWQkF6NjNzdkZiMndrUjdtcHUrV0tPSGU4VnpzQlhnVVFhdHd2?=
 =?utf-8?B?WElZeFBqdEkweW95MXhkRVQ1UkhyU29iN0gzeTM0U0VRdUxjWWltdlF4bHlS?=
 =?utf-8?B?NHVYVzc2dzZ5RVY2VkU2VGtaYm5mSTJ2aUFuVnFvY1JMWTU0Q2hjOGJndHU2?=
 =?utf-8?B?bVZQM1U1b2gwK2FyWEJTamszSlVuWk4wRFY2bDM1UmtPS1FnQmJYM05NQTdJ?=
 =?utf-8?B?U2tpZzN5TWphZGk5NTZueDdLSXdlYXdKOW42UTF2TU1USEpMdEZ6em9FcEdy?=
 =?utf-8?B?T08rL1hydjRsMWtvREo5S053YUsway9vUDhacVNCclNYVjdCNGs5a2h6d1FX?=
 =?utf-8?B?ZzFjWXNKWkZXalMvMlBaK1lqdDJnVVlaZGE5WkU0cEpOVkRiVkRzWVBDSDhI?=
 =?utf-8?B?cXoyOEhyZkZtWjJpRWJRelFER0NDaTNFTDJlMzBNNjJ6Z2lDMSsrekdJcmcr?=
 =?utf-8?B?Rk4wb2N6Z01JdUVablVxNGtOOVBGTFVlNndha2dieHZHRHo2djk3K1A4RTFQ?=
 =?utf-8?B?b25Bb0dDeVpSWWRFeFdJeDVrRXFxMGEyc1BtRjMwUGdyaml1dUZkYzhFaWFG?=
 =?utf-8?B?VlhUbUFVdTlpeEJTcUpxOTZPRk9NanRERnhRRTE5NUNoREZ0SC92MUxLcWt3?=
 =?utf-8?B?OHRzZ0xaSW42cDBrbk5EWDA5UDg3RzJKM2VKaHZrMmxyY1ZHQjY5RGJEbmVx?=
 =?utf-8?B?NDBwQmI2NDRzYm4xTDdrVjVwZUIvUG1YcnJuNm1ici9vVExtaVJ6TjdBQXlK?=
 =?utf-8?B?b0N4QjFnVk0zZzRXcDRLYlh0ejRJcnhINWhVcDRybnh1TFhmOGdxVExVallI?=
 =?utf-8?B?UlZlM2MyT3BHaDNIVDNmdzVDWDk0NkR2TFNFUmo1eFRZU2FiUnBEbGtMMnNp?=
 =?utf-8?B?WHBpazJOdHdYaFczR0dxVmRaeXpBQjJLaXlZclduN3c0Mk5oTlhYOGJkVmFi?=
 =?utf-8?B?SDR4NWtwTGQrNTJ3TFJjd01lZGV3TXBaeWQ5TVZJMTZsaS9xbmJsYndLRUJI?=
 =?utf-8?B?d1FGNlJjR3l2OUd1QklHYVB1UzA0amR0TWJmM3R4V2V5b0JmK1VmKytNNklx?=
 =?utf-8?B?enB0eU1PUHBXU2ViMVFiVFFaU0x1THljRks3RE9DWFdQWEcrU2tUVk42YUdm?=
 =?utf-8?B?enl1WkYrYjhxTnlWSXRCOE0zVFJjYkplcHFpTUUxTCt5Q1orNk9VYTNRM2tH?=
 =?utf-8?B?K3k0by9vQUt6SHdRUlQycjhtL2VabDR3bHhQV3NBNzRFcWg0TitTNjhvS3B6?=
 =?utf-8?B?UnROTGJkZlFMNjI0MDV0WURrN2UrSnpITWdyL0JGUmNsL202V3hYSmNoMURh?=
 =?utf-8?B?S0tRdEhvM1prKzRsMytZM2M2QzMyQmQ5c2FuM2J3S1R3ODlxaVpKaGU5bkx2?=
 =?utf-8?B?VzBNU2oyUXhYRHViSUtpeU5QMHNSNVpNajU3TnZ5YkhiUjBRY0ViUndRWUth?=
 =?utf-8?B?SFZpcG9ZbXBVempZb3IwTkR3ZFJPbGE2VndxQVNJM29hR2h2ME9TazlzMncx?=
 =?utf-8?B?ZXozT1FRZkY2RWZpRk5jZW90T2pYdGZHcTZ5ZktMSUZtc1VRRUpYZ1pkRjZw?=
 =?utf-8?B?aG41Z2UyQ1B6ekhwTGlZR3BLSno0TElIajRGdHJNVkNlNVJQTWhUYW1lVWt5?=
 =?utf-8?B?alFwY2ZkbDJUTW4wRDFPZWFxb0FDejhGdEhZYUY3STZ3aVlBZXVURkhKRVpC?=
 =?utf-8?B?dHJzSS83bzVEeEJib01IclZSa2cyeDR0T3hsQklVRGFHV2s2RmFLSkJucTVP?=
 =?utf-8?B?N052MEo0NEUvNU5WanAxQXV6QW85Q1FWRnI5VWNRbXJJWjl1N291YVNzWW9k?=
 =?utf-8?Q?vksge8vNkB4GWl6zrM3iIv56P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58513b72-bfed-4977-c029-08dce3dfbdd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:15:28.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJL2YZra4iYyUJAEH5b9X2qYdC2RkoyCqyM34c/Rd8j8eMsXZxlmSTm2v0MDpaiRQFCF3MxoxCWX7LGSEQKjdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

On 10/2/2024 4:47 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>
>> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
>> Severity, Device ID, Device Serial number and CXL RAS capability struct in
>> struct cxl_cper_prot_err. Include this struct as a member of struct
>> cxl_cper_work_data.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Defined array of structures for Device ID and Serial number
>> 	comparison.
>> 	p_err -> rec/p_rec.
>> ---
>>   drivers/acpi/apei/ghes.c        |  10 +++
>>   drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
>>   include/cxl/event.h             |  26 ++++++++
>>   3 files changed, 151 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ada93cfde9ba..9dcf0f78458f 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>   	schedule_work(cxl_cper_work);
>>   }
>>   
>> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>> +{
>> +	struct cxl_cper_work_data wd;
>> +
>> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
>> +		return;
>> +}
>> +
>>   int cxl_cper_register_work(struct work_struct *work)
>>   {
>>   	if (cxl_cper_work)
>> @@ -791,6 +799,8 @@ static bool ghes_do_proc(struct ghes *ghes,
>>   			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   
>>   			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
>> +		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
>> +			cxl_cper_handle_prot_err(gdata);
> 
> I would prefer this follow the format of cxl_cper_post_event and pass a
> 'struct cxl_cper_sec_prot_err *' directly.

Sure.

> 
>>   		} else {
>>   			void *err = acpi_hest_get_payload(gdata);
>>   
>> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
>> index 4fd8d783993e..08da7764c066 100644
>> --- a/drivers/firmware/efi/cper_cxl.c
>> +++ b/drivers/firmware/efi/cper_cxl.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include <linux/cper.h>
>> +#include <acpi/ghes.h>
>>   #include "cper_cxl.h"
>>   
>>   #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
>> @@ -44,6 +45,66 @@ enum {
>>   	USP,	/* CXL Upstream Switch Port */
>>   };
>>   
>> +struct agent_info {
>> +	const char *string;
>> +	bool req_sn;
>> +	bool req_sbdf;
>> +};
>> +
>> +static const struct agent_info agent_info[] = {
>> +	[RCD] = {
>> +		.string = "Restricted CXL Device",
>> +		.req_sbdf = true,
>> +		.req_sn = true,
>> +	},
>> +	[RCH_DP] = {
>> +		.string = "Restricted CXL Host Downstream Port",
>> +		.req_sbdf = false,
>> +		.req_sn = false,
>> +	},
>> +	[DEVICE] = {
>> +		.string = "CXL Device",
>> +		.req_sbdf = true,
>> +		.req_sn = true,
>> +	},
>> +	[LD] = {
>> +		.string = "CXL Logical Device",
>> +		.req_sbdf = true,
>> +		.req_sn = true,
>> +	},
>> +	[FMLD] = {
>> +		.string = "CXL Fabric Manager managed Logical Device",
>> +		.req_sbdf = true,
>> +		.req_sn = true,
>> +	},
>> +	[RP] = {
>> +		.string = "CXL Root Port",
>> +		.req_sbdf = true,
>> +		.req_sn = false,
>> +	},
>> +	[DSP] = {
>> +		.string = "CXL Downstream Switch Port",
>> +		.req_sbdf = true,
>> +		.req_sn = false,
>> +	},
>> +	[USP] = {
>> +		.string = "CXL Upstream Switch Port",
>> +		.req_sbdf = true,
>> +		.req_sn = false,
>> +	},
>> +};
>> +
>> +static enum cxl_aer_err_type cper_severity_cxl_aer(int cper_severity)
>> +{
>> +	switch (cper_severity) {
>> +	case CPER_SEV_RECOVERABLE:
>> +	case CPER_SEV_FATAL:
>> +		return CXL_AER_UNCORRECTABLE;
>> +	default:
>> +		return CXL_AER_CORRECTABLE;
>> +	}
> 
> Why does the CPER severity need to be converted to a new CXL specific
> enum value?

I was just following up the same convention here as done for AER..
cper_severity_to_aer(). I can change if there is no value in doing it.

> 
>> +}
>> +
>>   void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_err)
>>   {
>>   	if (prot_err->valid_bits & PROT_ERR_VALID_AGENT_TYPE)
>> @@ -176,3 +237,57 @@ void cper_print_prot_err(const char *pfx, const struct cper_sec_prot_err *prot_e
>>   			       sizeof(cxl_ras->header_log), 0);
>>   	}
>>   }
>> +
>> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
>> +				  struct cxl_cper_prot_err *rec)
>> +{
>> +	struct cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
> 
> Late feedback, but cper_sec_prot_err is too generic of a name. Lets make
> if cxl_cper_sec_prot_err similar to cxl_cper_event_rec.

okay

> 
> 
>> +	u8 *dvsec_start, *cap_start;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_DEVICE_ID)) {
>> +		pr_err(FW_WARN "No Device ID\n");
> 
> This should be pr_err_ratelimited().
> 
> This feedback likely also applies to the existing support, but I think
> protocol errors are even more likely than component errors to be bursty
> and persistent.
> 
> This error message and all the others should clarify that they are
> coming from the CXL CPER code with something like:
> 
>      #define pr_fmt(fmt) "cxl/cper: " fmt
> 
> ...at the top of the file.
> 

okay

>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * The device ID or agent address is required for CXL RCD, CXL
>> +	 * SLD, CXL LD, CXL Fabric Manager Managed LD, CXL Root Port,
>> +	 * CXL Downstream Switch Port and CXL Upstream Switch Port.
>> +	 */
>> +	if (!(agent_info[prot_err->agent_type].req_sbdf)) {
>> +		pr_err(FW_WARN "Invalid agent type\n");
>> +		return -EINVAL;
>> +	}
> 
> All CPER records without a device-id have already been dropped above, so
> why reject agent-types that do not require a device-id here?
> 
> I think this agent_info[] scheme makes the code more difficult to read
> especially since agent_info() is only consulted a couple times. Just put
> a "switch (prot_err->agent_type)" in the code directly and skip the
> indirection.

Hmm, I initially thought I would do switch case and then changed it to 
if-else thinking that would look cleaner.

What would you suggest? Just incorporate switch case similar to 
cper_print_prot_err() here as well or clean up switch case in 
cper_print_prot_err() and reuse the agent_info[] there?

This agent_info[] would include 3 fields then, two as above and another 
for valid_cap. Maybe unify sbdf with valid_cap..

> 
>> +
>> +	rec->segment = prot_err->agent_addr.segment;
>> +	rec->bus = prot_err->agent_addr.bus;
>> +	rec->device = prot_err->agent_addr.device;
>> +	rec->function = prot_err->agent_addr.function;
>> +
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
>> +		pr_err(FW_WARN "Invalid Protocol Error log\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dvsec_start = (u8 *)(prot_err + 1);
>> +	cap_start = dvsec_start + prot_err->dvsec_len;
>> +	rec->cxl_ras = *(struct cxl_ras_capability_regs *)cap_start;
> 
> Where is the validation that the size of the RAS field matches
> expectations? I.e. what if the BIOS builds a bad error record?

Will include check for size.

> 
>> +
>> +	/*
>> +	 * Set device serial number unconditionally.
>> +	 *
>> +	 * Print a warning message if it is not valid. The device serial
>> +	 * number is required for CXL RCD, CXL SLD, CXL LD and CXL Fabric
>> +	 * Manager Managed LD.
>> +	 */
>> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER) ||
>> +	    !(agent_info[prot_err->agent_type].req_sn))
>> +		pr_warn(FW_WARN "No Device Serial number\n");
>> +
>> +	rec->lower_dw = prot_err->dev_serial_num.lower_dw;
>> +	rec->upper_dw = prot_err->dev_serial_num.upper_dw;
> 
> Serial numbers are u64s, so if any conversion is to be done here it
> should be from upper+lower to a u64, but then again see below on my
> question about why a new cxl_cper_prot_err is being added.
> 
>> +
>> +	rec->severity = cper_severity_cxl_aer(gdata->error_severity);
>> +
>> +	return 0;
>> +}
>> diff --git a/include/cxl/event.h b/include/cxl/event.h
>> index 57b4630568f6..5b316150556a 100644
>> --- a/include/cxl/event.h
>> +++ b/include/cxl/event.h
>> @@ -158,11 +158,37 @@ struct cxl_ras_capability_regs {
>>   	u32 header_log[16];
>>   };
>>   
>> +enum cxl_aer_err_type {
>> +	CXL_AER_UNCORRECTABLE,
>> +	CXL_AER_CORRECTABLE,
>> +};
>> +
>> +struct cxl_cper_prot_err {
>> +	struct cxl_ras_capability_regs cxl_ras;
>> +
>> +	/* Device ID */
>> +	u8 function;
>> +	u8 device;
>> +	u8 bus;
>> +	u16 segment;
>> +
>> +	/* Device Serial Number */
>> +	u32 lower_dw;
>> +	u32 upper_dw;
>> +
>> +	int severity;
>> +};
> 
> Hmm, 'struct cxl_cper_event_rec' follows the raw format of the record
> from the specification, and 'struct cxl_cper_sec_prot_err' (formerly
> cper_sec_prot_err) already exists, so why is this new intermediate data
> structure needed?

Yeah, the intention was to extract only necessary info to be consumed by 
cxl_pci driver and to be passed to cxl_cper_fifo.

Going forward, while handling protocol errors separately, I can send the 
entire cxl_cper_sec_prot_err.

Thanks
Smita

> 
>> +
>>   struct cxl_cper_work_data {
>>   	enum cxl_event_type event_type;
>>   	struct cxl_cper_event_rec rec;
>> +	struct cxl_cper_prot_err p_rec;
> 
>>   };
>>   
>> +struct acpi_hest_generic_data;
>> +int cxl_cper_handle_prot_err_info(struct acpi_hest_generic_data *gdata,
>> +				  struct cxl_cper_prot_err *rec);
>> +
>>   #ifdef CONFIG_ACPI_APEI_GHES
>>   int cxl_cper_register_work(struct work_struct *work);
>>   int cxl_cper_unregister_work(struct work_struct *work);
>> -- 
>> 2.17.1
>>
> 
> 
> 

