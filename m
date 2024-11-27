Return-Path: <linux-efi+bounces-2220-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4649DADF0
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 20:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD52822F7
	for <lists+linux-efi@lfdr.de>; Wed, 27 Nov 2024 19:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2969202F75;
	Wed, 27 Nov 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VN3xdB+J"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E1201029;
	Wed, 27 Nov 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736197; cv=fail; b=Scc/0r5IlXAP67au+uoCuqDObXHNajYFE2C/0CC2BagL7itNqwT3qZCxG6nG+gijlIZTsi2ijLJsvbfuOGOgWGtuhtl2G0WqzlVpXtAoWJewSCyGUTpbOeHxcReLAl31fxpfogFG9k2wHeH3gqPjc8V6BG6GzNzMImIJ2u+EYSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736197; c=relaxed/simple;
	bh=+MuarCEPgQl9XjatoXhecanMrbBuctWggSuunSgbVCw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=ij6cpkKLhak9Mc7vnoKvTWYYU6nzXHKctTE87obxtrU5wmZe15BUGEsSBLfN7NVMubwJ+aVAJJWwKRz22varmmjJuucFpIseX6AQSlaPq/CnTXbL/oskGmNSVQFOTlbzvpe1gft3mtgwrmBpmtfQ2Vsnug/xFclQcL5FhQwjVqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VN3xdB+J; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C28E/FnffnOxb2OYPQxl15cHgiB1m2k65S26HGVF0Gcnpy4dH1doaINIMAmBzNonysq5+EXcUcfez4xdOHFDky8Ed9HjjLbFNu4mRRQVCc+OgBB7t+MryqNrhYxeWt5Rx35VBdOJ2pvxCxugMNz2Z8gTms9T3AspGh559wKwinYcSuIL5R1sji5FTqYhMgo2470EUiOLIczYhzL2SFahQR8smtY6d2TLwvKKon6uN4MYiI/eH8vopzEgp55hAhjccYdXERZZpFJQbYd3o6vvv0oZEs4dfNwnGmrRRyV4yLBMpi9ysaVUgmylfuA8Di9I/1wD3QsPSyiIPNfsLSQL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc/UcTtMwONDdkGBNj0MTDfZExZWGi3fGKFKUatLHQM=;
 b=tuapdTeld5x+6CAJnGAuACFwk6/G2TWPuvtbzvLJ9cA1WEnyhqtAliScIOuGZLlqXp79V4T9RM05ffPAvuTtSoD19KkYWD6hBE2u+MwPdYKM99vnqOvjY/lYEU4lAZMXOtV82vLcmmkElK2svwTVxU7JhzM9q1duTDOMlpcJIm/7Upp1guDYC5CKY9Noyf/xmrtk/0+JOmTIrl4knsmoWRF0qezQthQyXhEQ+v7h3YjDQCGguKmFoDU/dczpB+pXTv/O1F7/YoNgPFjgcIUasW13yjFa+BypVeaLn08PIvFddWYXpaCrn4kQppxx2LCCWhFT5xNTQnnFjWa6ebhniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc/UcTtMwONDdkGBNj0MTDfZExZWGi3fGKFKUatLHQM=;
 b=VN3xdB+JRuQtqqpvjqsXKzY5GSHlBYRrupC+nVtxyt8+DyJ0N0iJC5XsUwhQcM6hbckzlxwsaMYhglYc7ddh6vT4fcngTfytScmqXgUDlP1by9SB3aF2UQvDUhDkCE1L0qV8f9eiZKS953KlQwEa5J/jio06e4aea/wvuDKWKRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 19:36:31 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 19:36:31 +0000
Subject: Re: [PATCH v3 3/7] efi/cper, cxl: Remove cper_cxl.h
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241119003915.174386-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241119003915.174386-4-Smita.KoralahalliChannabasappa@amd.com>
 <20241126155111.00002d79@huawei.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <97ed072e-e32c-201e-69a1-1a43fc98ac4c@amd.com>
Date: Wed, 27 Nov 2024 11:36:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241126155111.00002d79@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::24) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c93522-e229-4fbc-9892-08dd0f1acb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajZueDBWTTFVRDRXTm5KNlFrRHN6dlN5cWlxc2V3eHVXeW9Ob0pGeTFVTGl5?=
 =?utf-8?B?MEo5MlVSd1JNbFhtQUFWRlg5TG5mZjJuTlZTSHE4R1NxYk91ZngycnpqQ2Z5?=
 =?utf-8?B?cU0xek9RQjJrdERadmZlTUNxd0I0TmhKWkpON3kxZU4zQ3hkRE1VWmNwaU9u?=
 =?utf-8?B?OUF2MFZVU1pIWnF1RWM4OU9CRklraFFtOFFMaUY0SUxqOEs3OGhpSUt5Z2Jz?=
 =?utf-8?B?aTRqSU5heUFWaUFtU3g5MWsyUWQ5dlVHV2R1SnQ1cWFXVUhGY2xMWCsxYW5l?=
 =?utf-8?B?elJLOFF3SjNkckh2NmgxYVJTOEExWlRJY0xDclI3S2lTNG8vRUt6eXRlTnZW?=
 =?utf-8?B?SERVaXVUd01DRlJKQ0pVcnc3RTU3UW4veHd6MmNFNFJiOXNLYXhnMUtndyts?=
 =?utf-8?B?UGM3ZUc5ZERndXRsVWZJWHJnT2QwSk5INDB0WUNLSWhQRXBNWi9kSGkwM2pn?=
 =?utf-8?B?Znh3WVJjYnk5M2tFNVUyQ1JqUnArTWw4UlFvL3ZoWERYOW91NUVHb21Ndk5B?=
 =?utf-8?B?MWo3b1NwQktVdjFyRmZSZVpGdmpsbVhLc0ZCMEV6Umd1ZTdCaGdHNEpjOHJz?=
 =?utf-8?B?dklmZ0M3aEF5RDE1cnFYTHh3WmxKWGFnbzRpbkQydnR5NVV2eU1xZHI5RGhJ?=
 =?utf-8?B?K0dmM2lJQkdHSXJtOGZCWWhKV0ltaW5zTVllY1BoelZUTkxKWmlYanpCQVVh?=
 =?utf-8?B?Y0RSekpnUW1aSG05U01oWnNUZXYveEZHTlZaMDFXZCtqdFR0RGVWMjJCWGJR?=
 =?utf-8?B?ZUFhSXJCQzdtcjNTcjdHSE03cjNTUDA4NW9JYWlCMGpwUWZQRUxoY055N3la?=
 =?utf-8?B?Tll1WG56RHcwdk80WldUOFVNeDBLNnlhSlczOEZxK3N3SHVaV29iYXEwTk1x?=
 =?utf-8?B?c0pwMWp5cVl5ZjBuVGpOaUFZSnZrZlhzWnA0bTY0dC9LbStaVzl6b0VUNVRk?=
 =?utf-8?B?dlV0QzVweGtkeDY3cmdEQ1U3YTJwTkl6NVJ4UnFCbFB6UkZHdFdEN0NtN3E1?=
 =?utf-8?B?Q2RraGZCUjZGSVNscGNEa2thbzFlK1RueW5VM05iVGxuVlVFM0liOVJ4cmRE?=
 =?utf-8?B?aUVsaWtIYWlxSVJSVmhkd0x1c3VBZExsS2I0MVlUd1pMSHl0ZmZMN09ZOGRt?=
 =?utf-8?B?Y1VtR0I0Q1hQdTBkejI2NmtHclhCVEFRN0swSmRiS1NGKzhpUy9waFdMTW9Y?=
 =?utf-8?B?SXhHSWw3bEhyeVBxYkJxNXhRYmJ2UzZLTHVmWERXb1AwTDd6YU1uQWxRYkxz?=
 =?utf-8?B?Tk9rdUxtWlhKaXArTCtzZmptS1E2YWFCL1pLc1hEN293Skh1dGhZWjg0QjdJ?=
 =?utf-8?B?RnFUdDlEZjJIZTZjMDVOSVV4Y1p1VFF4R1poUTUyRWptVFU1amF2UjhlQVpv?=
 =?utf-8?B?U0VqR0lwNzMyNmU3b283L1pQRTQ2ZmpBMU1NRDNUaFFpb01VbnNmUDNGUlZF?=
 =?utf-8?B?SUdlTkQ5YmRVTm5ySFFPRVcxRWFObEIzUzgwRWdqTVJJMWtQMVpVNmFsVTFF?=
 =?utf-8?B?UFdIdUZaN0JaM1VCUUxWN3p4ZzFnZFU3RVVmNDdHc0hoOFJjYVhUeFJmM0VY?=
 =?utf-8?B?cG1JMXRPY1FWRTRvRWZiVTB4RmRVTk15SUZqRk9XRkR0eG9hWENzV0lrZS9O?=
 =?utf-8?B?dXBhYmdlWUpwWjBnUXZUL1c3M2gwT2J1LzBIblR4T1BKejhIUVVCZmwxVXlo?=
 =?utf-8?B?a25XRzJqUTNIT2NaREEycUFPR0ZEdGVZS0NRUXdXYy9DWGdaWUREcWFVSFRV?=
 =?utf-8?B?dEVWMDRBNDhlcnUxT2JORUNlc3lLaFJXZWs4ZWRBVWp5cTh0OURtUEtKZHJn?=
 =?utf-8?B?Q2ZjUzdKZXRQeFRwbi9SQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amNzOE10WFRSM0J6WU1ERmxZYm5mOEtZS0R0VXdNN216YmszVkFnbGtYWUFh?=
 =?utf-8?B?YkRQN01MRVdjbE5adkNNdmxBT1RjWUhtcjJNS2ZFNHFBcUdPcGNiUEwydTNY?=
 =?utf-8?B?aGY0VGtZOU80VTl0eDhqcXJjT2pDNHhMcUxMUTZJR1d3SHdWelVGdFJOOXhu?=
 =?utf-8?B?S05FTFBaaUh0YVpPcTdsWUcyWGdvQmV5OVRnYUtIaWxiSE1wcmU0bUFyUERB?=
 =?utf-8?B?VU14Vm52a09kTmlMM1dldjU3bFYxa0RaTWpxSkNzd05XM3lsZk9aaWFSZ1Ri?=
 =?utf-8?B?U0JOVGYxWXByMzh5RXVFcmRKOVVYWUtPamFYNnFzbmFpNlhlREgvSHNYVFM4?=
 =?utf-8?B?WlVVZjBnQnM5S1dpVGRsc3l1VnJFN2dMbkdmaTF6VkdWRVZTdW5HWHlxOVlv?=
 =?utf-8?B?T0NLNjRpeUpINENRd3IwZTZIdGpHZGRXWGd1eXl4QmxPTDRONEVxVURuTEMy?=
 =?utf-8?B?VllGU3hhUTBjTEJDRXNPbXFWSVh1MXpBcUNEc0cwOWtZOUdrUUlJZ2pjK3Jh?=
 =?utf-8?B?SjZTZHRxaGZ3MGE0WExqQ3FRSHJSVEUrYm1sSEl2bldEb1hWSFozZEtNWjI4?=
 =?utf-8?B?YTdRK084bU9yczlCMW1XcWNTWlRyWDJ1T3JxaU1zSUZWMUlYZmN4NzdXSVFJ?=
 =?utf-8?B?NFQ5bkM0SGJlUmNLclpVditrYWJUVDVnTmNmWXp4QUdyVi9TTkpvRXF6UkZC?=
 =?utf-8?B?ZkZIZGpuRy95cjljcWN6eUIxSmMwaGJkTDhVa2NYWnN6MjhBcTZJUTB2bjRu?=
 =?utf-8?B?cUtWTGd5eVkxb1NsOXpBVTQ2d0EzTHF3dG90QWc3akp2VE5WQUlwWmU3K3ph?=
 =?utf-8?B?b05QVFhuMkdIOEZocjFwZmNMOWY5SGVWZHJHenUrMmhSR2lyQ2sxblc4R2VH?=
 =?utf-8?B?OTJlOGRDSWswTUQ4aEdnWTgxQXY4QkxQK0dxRi8wV3F1NE5WRGRleEZveWx4?=
 =?utf-8?B?aWhVNXh5SXFFRXZyc25XbmJaN0hFN1g3UmVoaE5YV3FvWDRFOEFzbWRFSDFl?=
 =?utf-8?B?U0ZjUStnR3J1WG50aVdqRDdIeHo0SFg4U2l4Z1d3dHVjSW1KQ1gvK2RRU3lS?=
 =?utf-8?B?RXFZckVBcHhITmlldU9vTnFZbkFGdFduVUk3dlc1d2M3VWhydVFPYVBhLzNk?=
 =?utf-8?B?QU9oeW9zbFZ3Zy9vZlI3QnB1TGNGeXNidGNqMHA2U2VhcGpKSFdnNWlhZG9D?=
 =?utf-8?B?blpYcHZ0dEVVQndyUnJNcEFLd3V2ZEpaWmFCcWJJRkNnc0E2aG0rSUN6TW1u?=
 =?utf-8?B?S09BUjA2cit4QlVlWDVzcDh4aHMvMmtlSjM0TzJYbkRpUEFBc3ZVa0dsVXYx?=
 =?utf-8?B?QTc2NEpVU2xadGo5WTRJVzFQM2xjR3Z3VjJYS1ZjYm5XdHNLUHFUSmJNMnpo?=
 =?utf-8?B?U0ppcmx4dXFhTTR4K2ZzN2I2MVNTSm9mQzMrb1dNcUVjc2pDNUJzWUx4MHZi?=
 =?utf-8?B?Q0k0TEJ2cU1PWFNzNHo1dldJbmlxNEhOV2RyZTJIQlFQUWREMEdhRnVTTFp1?=
 =?utf-8?B?dmtRRzNmbjB5eDRBbFFIbjdwdWFTUFlwNmlZa1FTeVJ4bXVDRkhQRm85czF3?=
 =?utf-8?B?dzVldmttTjNidkViMXBKRnkwUm1WaEtaTGxjTDRiQVpHTWRYNmE2Z2hvaEpQ?=
 =?utf-8?B?UmQxTkdEcFZJRmdpYU5qRFBkVWI1VWFYU3NBM0JucFd4REg0U3Z2OFA0WmhE?=
 =?utf-8?B?am0wcER3ZzhHT1A3UnlaUU5VaE5hMk0waWsrREd6aXdXUnNYNis3QjVraHRG?=
 =?utf-8?B?czN5amdNNW5MQWJteGZrTXArMWV3elpXUG54dmZRNlNqMzhhdmYyMW9MTDdm?=
 =?utf-8?B?c1VMQTRUckZjWVFOREMyVTN2WVBMeGcwRDN0WWVkZDBXa0l4MFJqR2ZGV0FG?=
 =?utf-8?B?YWdJbTFobnlzYnFmWG5sVk02RE5MR3RXQk1BMEZSNjJtL0ZUM2VFUkFIbXhn?=
 =?utf-8?B?bWV5ZEc4UTZZcVdxMWpHV0Uzd3hZLzVzR2FmeHdaOVJiQVVJaFMrMXEyL1py?=
 =?utf-8?B?YnVkbHU0eVRMMi8xeStqRVZmQkxBR2FXL3pXYVo2UTdHUWxzM0pRR0VMdlVH?=
 =?utf-8?B?SkxxWDMwaDVLZ2ZjNVZDMkZLQi9QUmdmSEVjVCt2U1REWWw3VU15b1dBcmNv?=
 =?utf-8?Q?801SIQzTdEVd7oGdUgL/Iode3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c93522-e229-4fbc-9892-08dd0f1acb3e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 19:36:31.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkTmuV3kxAfaEzl0EbiCcsiZwAg9l9DH7vqE92c6HcigYQSGYX8heTfCxUDucVaoDo4EYH0+OFPNXslPHy0LVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

On 11/26/2024 7:51 AM, Jonathan Cameron wrote:
> On Tue, 19 Nov 2024 00:39:11 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
>> to avoid maintaining a separate header file just for this function
>> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
>> been reorganized.
>>
>> Eliminate its corresponding #include directives from source files that
>> previously included it, since the header file has been removed.
> 
> You lost me on this one.  Looks like only place these existed was the now
> empty header?  I'd not mention that as it's just bit confusing.

Yes. I will remove this sentence.

Thanks
Smita
> 
> 
>>
>> No functional changes.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> diff --git a/drivers/firmware/efi/cper_cxl.h b/drivers/firmware/efi/cper_cxl.h
>> deleted file mode 100644
>> index 5ce1401ee17a..000000000000
>> --- a/drivers/firmware/efi/cper_cxl.h
>> +++ /dev/null
>> @@ -1,16 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0-only */
>> -/*
>> - * UEFI Common Platform Error Record (CPER) support for CXL Section.
>> - *
>> - * Copyright (C) 2022 Advanced Micro Devices, Inc.
>> - *
>> - * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> - */
>> -
>> -#ifndef LINUX_CPER_CXL_H
>> -#define LINUX_CPER_CXL_H
>> -
>> -void cxl_cper_print_prot_err(const char *pfx,
>> -			     const struct cxl_cper_sec_prot_err *prot_err);
>> -
>> -#endif //__CPER_CXL_

