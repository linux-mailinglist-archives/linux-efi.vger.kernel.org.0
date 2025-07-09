Return-Path: <linux-efi+bounces-4260-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF1AFF0B1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F331C41A48
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20642A99;
	Wed,  9 Jul 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RBUjV+ku"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FE79CF;
	Wed,  9 Jul 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084986; cv=fail; b=ui1WgGRvFJFP3i0CB0+fFTU4AOtXc0tPfSw6QVgZ3n3VjPFH2ndtQlo1BQhLxONkNBT4JfhQKH5L7m0iXs+nWaH05p5UdXBycH36E9oW43nBLIPoxq59UIvwlBBWR20pKzWdr/Ln+g09KIqGk5U7DgWlCZJM75waWsVy4T6iHdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084986; c=relaxed/simple;
	bh=SProVBB++M15O+8LCqs1EObnvrv1cfGtjzqvTqdSyMs=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=FP3D9kux1jufOQrbyziinL4cnCuO66OIcmLI7YzjbhVN1fVGPeLLOeqfj624vHJhAiGxRtUXCqZT4GMowTqdsJwlo6ZLUWlvZSggu75xaD7yVIIX32DHkXfblsAqHaWH53aXhsBGwyjT72rQ3IfR+LVsojXT1XWSFJFs2WU7jWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RBUjV+ku; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liOm26PgTHGzkdCZeko5QlcVSWntnP9s3eDOmLywFQWIFnZev6+5ManlejAjmMF8NcbAk5eZBzDxpzPiUGICpsz3qPCOUL1TW/n5OFNXbYS7Eitp2TP3ojbMEePcNAs0okVBclXgIDO70wE90XCl3QAzUSViAV9vRIJFLhVonJE1MJC8TXCTO4c3XgRaTn9/SHRfIk2I23V2A80YUmHXA9ZCud1aETLDYufTfHUafv3CZsinv/zZjPYGcVAwtT0WUV4wjp+sOHVHQKvonp/MZdPCb7+Yj8I5d1WeZ2lWYG9E35OkufjnPhBFp6wTY/Qi5dS9w3KuBE7r4pueQiV/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNlInWuY4nbXmj+CfawwWqopdAkvkJWTI8nZogvYdBE=;
 b=MKEEBTwjOYACtwlEvQYxjpfVeJNjAcgazlBh9zM6fO9QchuC1wfbmKDAIQfypsA4Is2HW4rVnU79YA/+YQeQ6xlmHJsFwfupGAn3cXzruIFKAS3AwW6LGc++DIIYJfeE8lNIVWVVXDCS5XrUSw67pGrQ21Forq8GXKKicv8GXuE7EVP9dZucT3kKAxzHlab9P/MYrqXA+EF/P/EbY2cOGeffbiY0Lxp1GD8TXPYA9yw0yUW4sjBFerBGIpMp+9eRiUGLV5u4tdxbpSQizDzNZH3UEItjy1I1RlsEg00jCs6Gc4zXaS2vLBBRAWywsSdlIsIRGz8ymVxPN+XYvKBHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNlInWuY4nbXmj+CfawwWqopdAkvkJWTI8nZogvYdBE=;
 b=RBUjV+kui6SK8gphBNG0DevZRm0TFjoJyvmCmbu4BnyqFmu6dwP+L2Q/rbFdZGY3QYAevohoyQIloTNXVYpl1vNkEJig/0IH6Hop1xPQUeIPHJ+9iW8M8wzRCRiB4D8tpS8CcfO+fgLG9uy8vxyh0X1qwGQdSHaKrz1t46SGIXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA5PPFE91247D15.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 9 Jul
 2025 18:16:21 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 18:16:21 +0000
Message-ID: <80710331-7dd5-ac7c-5013-3f198e9fd72f@amd.com>
Date: Wed, 9 Jul 2025 13:16:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-33-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 07/24] x86/sev: Move MSR save/restore out of early page
 state change helper
In-Reply-To: <20250709080840.2233208-33-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:805:de::26) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8a587d-91c1-4624-1ccc-08ddbf14b4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlpXN1JLUitsbkpPanlJZXkyVmRZN3JyaEJwcnZyUlBpV3QxYVlDazh1SVpQ?=
 =?utf-8?B?eXFoMmtlYjNlV1dMYWx5MSs5NndvTnBHQ0FaTUliMkVuWHFsNnhjSVJiTWQ3?=
 =?utf-8?B?MHNrZW5hRUg1UTdSd2FXWWpkRnh3ZEkzY1cvT2Q5Ty93RUVtZFZvcWZVcy9G?=
 =?utf-8?B?MTEyUkJYcXNBeTRWd3Evc3pmRmR6OFJqLzVnWjhYL2sxeitRWGt4N0FrNEhF?=
 =?utf-8?B?aHRRR0srQ3RQTVA2RVlRNWxUamI0ZlFldDRDbzRMc3ZlTUs1bXhXaGZJdGlZ?=
 =?utf-8?B?MlNocFE3dlFvcDZRemIxQ1hqemEyNWY3U2VSdndIQ3c2Y2llSG1mWEF1YmZJ?=
 =?utf-8?B?UmExSWtFRXl0YWs5dVN6b1pYRkx6YWszTWNYY01BK0RTZ1BJSnd0TURya0pH?=
 =?utf-8?B?T0t6TXpxQkZBMWY0M1FsNTlmQ2RJMTFNVHhKbEZQYkpRSDEzTkRZVEN4R2Yv?=
 =?utf-8?B?dmVrV1grRHk5V244VXJuODNRWlRoMUlDdTdGVUl5aWpMRHRLUzA2NER6VkhZ?=
 =?utf-8?B?UVdxZVJCNnpxckIwc2pwM09IUitvazBlYXE2WDdYNThWd3NIQ1Y2aVBFYVFF?=
 =?utf-8?B?UTlOVnBWMmNReEdyTUFQUDZPMEJNZCt4WHJIWTlYemViT0RrSlMyaXQ2cWYx?=
 =?utf-8?B?d3plM2p3YjJQM3RYakgxRXdZLzErQkNCamhKQ0lBTzBFZUttZHBkcDdhMkZZ?=
 =?utf-8?B?TTlJM0JEMHdVOUZYN3N0dHFGZ1N5ZDRuTFpDeXh5b21PSTIyU1MzWlNrYlg5?=
 =?utf-8?B?akREYW5mejBaSUMzRWtMbE1Id2ttWHlXR0svczNyaXM2eHVwRW5mekk0alNt?=
 =?utf-8?B?MThhZCtvWVBkSGc2TG1JVk9HN1N2bUtzQXhtUVpqejQwdU9ReW42RDhFcFRi?=
 =?utf-8?B?M3gwdTduNUxqNndNcytoZ212Vk9leTBzVmFnUzB1NG15Z0xqNW1DWktnVm5H?=
 =?utf-8?B?VmU3SUt2RUZXNms5QXk1MHVqQnhJQ1pDNVJqQmFrdXpXSjFWZEUvT09ML2RW?=
 =?utf-8?B?SnBtTDJLOFFWcllHbFZ2MWplSU82QkVTWmtxVXA5VlNRSkk5NFBibkZTUmxE?=
 =?utf-8?B?MjlWNzBscy9zZjR6blp6aWtUU0QyTjc3a3hwVmRwUGZ3VDQyWUdIUk83anI4?=
 =?utf-8?B?ZHBFRXNmdU1mcHhEOSs1YjN0Z1c5N2xqZjgyMk9Lalh1bE9IV3NVN3pON1Bt?=
 =?utf-8?B?RVU3WVpjbDNseFZyRmZTNVBCV3RleSsvT0luaGszS0pLRk50MjA4ZHJueENa?=
 =?utf-8?B?VnA3VFNIZWsyWFV4RHRDUGg1ZlJ2WEIxbTRTTUVHZ2JIUDhqQTRaOWhCMzgr?=
 =?utf-8?B?SVNSYzVXNm5RclNROEJ3Z2JadFlNQXVyeVNoOGpISXdNZGlyZ09JcEgrc2pO?=
 =?utf-8?B?TVdpUzVNZEhuK040MUJ4SHNZYngyMVNpL0kxVjlPcm5xQ1hPVGlpQUNXdFRs?=
 =?utf-8?B?TzdNUmdIMmplbG9KVk12Z0Vqc2QxeWZHc2lSN3crdExJVEc4azVESlZ3M2lq?=
 =?utf-8?B?Y2l1OEtSRXhjWDZ4QjVhUXl5bU1yTXZxdFhUMFZlaXZRbmduYzcxUC9tOStp?=
 =?utf-8?B?bUluL0Vpc2NwZ254RW9wTys0S0VVUTU5NzV3RUNFV21RMXlnd1N2elowVFpM?=
 =?utf-8?B?cjFhQ1poVmpVdmtGQjdRbEplWTZUL3pQRnZRUEtSS1gya2d2M2ZHQWZhZUY4?=
 =?utf-8?B?Z2owMk82bTk5bGNmT012Q1dXZ1hscE02Y1VoRWhzUEFOOExkTVpqeGtSSlNY?=
 =?utf-8?B?YlBZZnN1MEorS21yQTd1M1JneTlEWXNWOEh0ZFViejk5SERuZXFVdHgxT0pl?=
 =?utf-8?B?MGpjSU9ZVFQvMEpyTExqczR1TXJac2NpRVJWSzYzREdwOUZJVVF4VnlEa3hE?=
 =?utf-8?B?K1Q1NUZ5RXRvYmphOHFObm1qTVduK3ZqY1J1WExManZ6Q3ppZnZiN1NkanRV?=
 =?utf-8?Q?AHmqKP0tAxY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGY2WGxXOWcvRjh1ODVHbm81NkJ0WEl5S1k2QkdCSWFhMDlEeGEyQUpBYzVJ?=
 =?utf-8?B?cEFEQlVLU2RScGdBWkFkc1kvdjVwZmNJOWtRUmhxWCttMU9wTURER1Q2dmg5?=
 =?utf-8?B?NzZmMmJmN3dXbStKMG1NZURjbkNBWmlUYVNwR0VzTFlEVk5uZXFic04vVk05?=
 =?utf-8?B?OEthM2VyVFNOME85dzY5N1lGRlYzenU1bklEUFYrM2k1TWRRUFFaOWdtalVx?=
 =?utf-8?B?TSsxUHkyczdoMXhqdHlxaEFrbGFwU2tsWEJQRkZsV3dLMGJpYlRZSWVwWGgv?=
 =?utf-8?B?V2lKRE9jNjQwNGNZamJ0T3hZUkhiK2FMMFNMazJSZk9zYVo1OXhnYmhKOTkw?=
 =?utf-8?B?MDMrOEhqNXB2dGwvWTIzQWxpOU5wSzFrN1JubStuVWFONzl3bGZUMXh4dWY4?=
 =?utf-8?B?b2V3bGlTMml0aCtlemJIU3hOV3F3K3VGcW5teVdYNldKK05PL2xTSkwrd2V3?=
 =?utf-8?B?QWVybWdYUEtyaDRXNGVhSnlNa2FKRXpXUDNOdzlzYU90K3gxQXF3QWRObG90?=
 =?utf-8?B?dFJFL1ExVktFZkZBYUtzd2Q3ck5IemIyNVJQdFFWOHlSellqN2VnN24wK0lZ?=
 =?utf-8?B?NHo0N2Rma25odm9Fa3lSV2dKWi9hSERxdkhwVmE0aXMwcXVaemxjd29qNkI0?=
 =?utf-8?B?UVNOR25XY2g3bGIwd2gyMmNjVUx1d0lBdFpUVExGWklYUzNpZW5jSVlMNUpQ?=
 =?utf-8?B?RXJnd1hWQjY2UkhaM2FuRy9rMjhnRXhON3pTay8xbmRza1hDTE8yZllFS1FN?=
 =?utf-8?B?ODBSa0RrWWlwUDczVFFPSmJxcEx3d21GL3RKSHVDOXRXS3MwaGg1ZWZmSlA2?=
 =?utf-8?B?MFN1bjRPVm1GZXJha0RHTnhrVlkvN0hCVWRoODhWZDRHcFFnaFR1dXZWRGlT?=
 =?utf-8?B?K1hmT2FSUG5pYnIyUEhXQ3g4VGRUVnFZYTMvTDg4N0Jjai9DL0ZvOC9JNSt6?=
 =?utf-8?B?enVhQWszWlBNV3puaVpibXF2MVpQMmpxYkYyQ1A3Qk1XUVAwZVpKZjZ5NlVQ?=
 =?utf-8?B?cFV3V0treTF5YjU1UVkzQ2tZVlJ3czQzZTQvVFN3ZURzclprTjA4VUdqYk1Z?=
 =?utf-8?B?elNNR1NUblNYNkNGQnBGd3ZKUHVTM2ZPUHBGWVhvM0NXdTVnbys0dEZZL0ts?=
 =?utf-8?B?ZGpOaXc0bXdKdFpjN0padCtlYno0ay9VTE5aYi8wZkVhdkVNSDNFTTFpNVV4?=
 =?utf-8?B?QVFmY3dKc2FYZ0NrYlhWbEJ1LzVGeVQ1a2xNQUJXd3Z6MjZNNUovay9kYzFq?=
 =?utf-8?B?VzJTVko0OFUycUJ4aVN2OEREek5GTUV3T0J3UlJWMkxSWXdodG1tK1ljeWx4?=
 =?utf-8?B?Tnp6L05HREwyYjFyenJSbEVUTGJaRy9UVS9RZ3ExaklkbkRXd0t3TmhIQ3RB?=
 =?utf-8?B?WG5hVnZpVlRDRkVoWmVDQmdMbjlQQlhCYnNpb3d4b095M2xoTGtrWTNReHhN?=
 =?utf-8?B?enM5WWhvV0VpQ29vVDFkeXJ3RVcxRFAyT1lXOTVEYzRrVkZVUDBpbXJ0ajF5?=
 =?utf-8?B?WjQ1RXkyVVdVb3FjMnpiSVlJTmpacU84aXo2SURPMnRWSktsQWJMUXlSTUxS?=
 =?utf-8?B?eGY4OTgyVHZzNHA4T1JNZnJvanhTMW1ydE5xeUtxeXRLeFpodUF6cUdMZzRH?=
 =?utf-8?B?SEVSeGJKNEQ3WFEyL2w3c2xTSlZ2RWFsclpSWE9LMWVGL3dVd3d1SUFyc25D?=
 =?utf-8?B?SDFHZ29pZWJwa2VxbTRKaWVSNUFXa2VwL0VYc0RiR0ZCd3BIbFQveXJJRzJZ?=
 =?utf-8?B?czcrZjQ2eENUbE1pOWxUZ1YwbnlYU1JuYXNhSndLa0cwV2EzTG1kV3F2K3Q3?=
 =?utf-8?B?d2NEWldRQ2RkeXZzVGtIRERxRkNFV29od3ZmNlFtZ2Z0ZGZGZTYxazhxUlVS?=
 =?utf-8?B?OWpaVmRLSVc0WCs5TDhhOVpzcWZXc3NRRWJlcTZKWmE4c2kwTXExdWE2dHpu?=
 =?utf-8?B?WHpNM3FCa215UEY3T3lubmx2YkdHS3lwN2ZOZkZEWFc4ZndvZi9GVm4rblh2?=
 =?utf-8?B?cjFTOEJyUEhhSU51bkpPUzZPcVJ2NEgrL0hvSlgzUDVJU29aWnkwcHRieUxL?=
 =?utf-8?B?UzYyNUx6WkIrRFJTMElMQ1JTRmEyUXB3S3hJSUhtZ3FEdm54aXRtcmd2Z3do?=
 =?utf-8?Q?5oxECL6T8aRrcieRC4zVyaG1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8a587d-91c1-4624-1ccc-08ddbf14b4c1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 18:16:21.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEsiYr6SuEVo6ELvD8XXmpuBOBNe59US86EjwmsE/JN9OHgn0019222NMtyHLrW3BQ2Ge8IofTMXjwXU3nGz9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15

On 7/9/25 03:08, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The function __page_state_change() in the decompressor is very similar
> to the loop in early_set_pages_state(), and they can share this code
> once the MSR save/restore is moved out.
> 
> This also avoids doing the preserve/restore for each page in a longer
> sequence unnecessarily.
> 
> This simplifies subsequent changes, where the APIs used by
> __page_state_change() are modified for better separation between startup
> code and ordinary code.

The reason for the calls being in __page_state_change() is because of
the call to pavalidate_4k_page(). If that code path is ever changed to
cause a #VC, then the GHCB MSR will be messed up when the UEFI #VC
handler gets control and will be an issue.

Thanks,
Tom

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/sev.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 6c0f91d38595..f00f68175f14 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -71,9 +71,6 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>  	if (op == SNP_PAGE_STATE_SHARED)
>  		pvalidate_4k_page(paddr, paddr, false);
>  
> -	/* Save the current GHCB MSR value */
> -	msr = sev_es_rd_ghcb_msr();
> -
>  	/* Issue VMGEXIT to change the page state in RMP table. */
>  	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
>  	VMGEXIT();
> @@ -83,9 +80,6 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>  	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>  
> -	/* Restore the GHCB MSR value */
> -	sev_es_wr_ghcb_msr(msr);
> -
>  	/*
>  	 * Now that page state is changed in the RMP table, validate it so that it is
>  	 * consistent with the RMP entry.
> @@ -96,18 +90,26 @@ static void __page_state_change(unsigned long paddr, enum psc_op op)
>  
>  void snp_set_page_private(unsigned long paddr)
>  {
> +	u64 msr;
> +
>  	if (!sev_snp_enabled())
>  		return;
>  
> +	msr = sev_es_rd_ghcb_msr();
>  	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
> +	sev_es_wr_ghcb_msr(msr);
>  }
>  
>  void snp_set_page_shared(unsigned long paddr)
>  {
> +	u64 msr;
> +
>  	if (!sev_snp_enabled())
>  		return;
>  
> +	msr = sev_es_rd_ghcb_msr();
>  	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
> +	sev_es_wr_ghcb_msr(msr);
>  }
>  
>  bool early_setup_ghcb(void)
> @@ -132,8 +134,11 @@ bool early_setup_ghcb(void)
>  
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  {
> +	u64 msr = sev_es_rd_ghcb_msr();
> +
>  	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
>  		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
> +	sev_es_wr_ghcb_msr(msr);
>  }
>  
>  void sev_es_shutdown_ghcb(void)

