Return-Path: <linux-efi+bounces-4254-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD43DAFED7E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9545178FE2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEC2E6124;
	Wed,  9 Jul 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J3CJRTZ4"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169A42E7179;
	Wed,  9 Jul 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073974; cv=fail; b=WJvdSiillTNUAa/85bLm2fdbm007qknANeZHmnOf33GmATpr2U8wx2Bcmqe5ZfCw2wDgJapRR/jawMlR8KQeoZBA9VdL0kbPtlcQBixTvZb9OSQT1WArapQFlrtiAH00pk05Vrf2zg2xmawSsWpkNqzpRD+kVpJzd+Es9wHwAYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073974; c=relaxed/simple;
	bh=8gar+aF11aOVwyRc0Vc+y9zJIX6vYSTeK6UHED230eo=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=dgEnPTC0qlnUKCD6ZDO8vxktXY9bj8YFoyGkVj4RZrFTSLJC6Fax09FPgMr9GiG9wJirc/x79e8tg8msz+dVHGjctKUkgWdvVMHWVe8O3jF3i5IjePGMqCE+Awwh+G7oyU4rzpy75PpsQqYM6/VUdR81LJEaNCW8OmmUgYSCmUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J3CJRTZ4; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff7M/053W/F+Nir9ViYDRmFXQN8u3gPDBaIJ9Iu8YHBDJ+aPvL0MXXfGcu79+KgcfaDSYjWYewataiWCxWNog5B5v+4INMvAGd6w34E7KpABYhql2afHZk1FbN8JYidAWF79FuiEavaJtfbIZRkQjxtWJaGuUbnwILvf+l72u3Ch9xWdXkzP3CGUdUry9Z1ftcM92sSZk70OPfXorw8Hh08O8tviv1/s+cBrpej41mScylD+sESqSq9p58NIEtMXeK3H7yy9VR/UOYvPNPVZ2pcQLhO0J51yQKSVZc1H4IaMY/Rmie1R1IgUAE5rwAHAJVw+Dc6eQkuhT/UIDt40KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo7iKtpyIW0Cao2RXsHWiix3Hz6ThI2OgiGHKifbtlQ=;
 b=b0QIC3siETmwX8rqX+JFNsGypajlTOm0w4RfGkTaSDILgR1l6264/90u1oxCuHjsfLZVAuiVGk4AHCyBhC6dbU7GChJ7zKn0ZY8QKMJhzz5KF9w4+9p+EQitBtwLYbX5AzxXiA8fYTPDs7SrsSji/qCRj7OaSzveiehbZZEVmp3tQ7syGVIpGvRfFJJQmFjOXhyTJvqgZY/6XoXGS824AiTfl2D1nm7sdTvY3FgKZ4JgXTbq6qj3NIWGqSVjTjn1xiuw7Y/Mg5Ax6wUrfcoBOtbO3QRIj5mBgVc1NOZ2UsJ+GQ/JJF2wfID9zNkbJ8LbcpRbRQzPQQin1tR3cPAwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo7iKtpyIW0Cao2RXsHWiix3Hz6ThI2OgiGHKifbtlQ=;
 b=J3CJRTZ4Cxl9BiMCEr2l/x2C2ywLWBcwu//uGHBCk+vXFbhh+AQCvq4lcP3m9LtCsL1hHZBhrPF2duJexBOGWjYhPO6xTT4MRdnI7D8QJntgczHFSxwbgrhQDL/MyphhoJPt2pT/VSsip+yIpwr3+5KsnhBrEStJnha0D4D9STc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 15:12:50 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 15:12:50 +0000
Message-ID: <74889161-adfa-3547-d8a9-3ff154098c7a@amd.com>
Date: Wed, 9 Jul 2025 10:12:48 -0500
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
 <20250709080840.2233208-27-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 01/24] x86/sev: Separate MSR and GHCB based snp_cpuid()
 via a callback
In-Reply-To: <20250709080840.2233208-27-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 315b4e6a-f32a-439c-fdc6-08ddbefb11f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk9rdVE0THpRODA3cFdkbnJFTm1abXNyK1VSSzVoR09XdlFMNVhlY2pvSW14?=
 =?utf-8?B?bFJQL2JRQnNmQkwxZEpBQ2ZQMDQxZWRFY3NBaDc4bjVSSm8vd2JpNnY4TEZN?=
 =?utf-8?B?eDVZZ3hZZDRnSlZCNXhCVlhVRVlNZzJML3JHbklXRHBzK2hhdlNjTkVwZnJi?=
 =?utf-8?B?eDVZWWo5cWFDRkt2QktueTVhdnMwS201WThLbllMR1ptQjhYdXFtNHluS1hE?=
 =?utf-8?B?QVA3WTFGaWU4SlpxR1ozaFhGbzI3TnhuNTJXR2IzdC93ZzVDVXBCTXlQZy9T?=
 =?utf-8?B?c0xqVUk3MFZKa2VvczlSb0k4dmNxVzE2QzNBTi9SKzgwWXJEYTJxVnNzdTVr?=
 =?utf-8?B?NU5ldDczckJLdmZsTitkVzY5eFFrZFBCQ2lCc3dzYjBQL2NLZGNlaHZTS3FR?=
 =?utf-8?B?TzJCV1pmU2JWUFcwQXFJOGNvdGhJY2NYN0RzblNyYngxaDcxMEZ2c1hiZm8w?=
 =?utf-8?B?RXRhbXlIaW5FUHhCb1lJR0dQblh2cTFGRzdsYUp6cThEOGZKTnpSOUhUZzRa?=
 =?utf-8?B?SXdlRS9sMTNTTWMwTEwxU2V1aFJlbVFaNCsvT2RBNE0rZVRKaXZwMWNmazhV?=
 =?utf-8?B?MXZtaHJXT042WFp3NmRtdkthMDhrZDg3dUNNZ1hlcnY1OU5acmEzMTdqV2da?=
 =?utf-8?B?TTVHTGhkNCtnSkpIcEpiNi9DbDNTbzY3WXRGNzlwdzFvOTdocy9sY1JNdTR6?=
 =?utf-8?B?WFR4NEpQTzJtMXRScmQyZDVPM0RxS3JlMWVZc3JpQ3FEYkhSakxUcGlqUEww?=
 =?utf-8?B?dzNGUWtwczJzZ0ZPSnc2Q0t1S3ZTRThBYzBvNzFpWmdpZFVBVXVUM1NTc3pG?=
 =?utf-8?B?S1haMmhQVHlzaXd6a0dtL2dOeFpwc1JRNTZod0ZFODNhUUF0RWFXTkVFdTFW?=
 =?utf-8?B?ckx6ZGFBVmd6RUNiUTZORGZpeHVscmRhV3JCSjhMU240VGFDaHVLeDdkOHQ0?=
 =?utf-8?B?UkZPSTIrUnJBcjJvRk90WmZpUzcyeVlEL2R4Sk5yajdhNFJpY3d5dFJJODgz?=
 =?utf-8?B?RjRuQ2hyd2FwVEFsV3FSczc2MWZnUlJyVFEzUDFoUGdXZEcwT2w1bys1K09C?=
 =?utf-8?B?VXVxSTFmcnpLdnkzTEhNTVlqVElBRGJ6bG1oeVpQcnZlcGdkdzZuUU85cTNv?=
 =?utf-8?B?cU1oekJsandRWEdQSjJqbGlvcDErdXVaZlgvNlpBQVJyY0NKcFRUQ2pYT2hN?=
 =?utf-8?B?MGNaWDdkM2NNbEJKb1F0Q0Z6WkxtcVQ2SHNzTUxVK3hDcks0NlpCNWJ5VWNj?=
 =?utf-8?B?bzZqNEFkZ0V0ajdXNEN3enVESDBBTEppY3hPa1JQN3JJaHFaUmpWcFZydmhx?=
 =?utf-8?B?a3ZkaE53YzNyODU2cnlpeG00SzRaV25SUlpFZzBqUThYc1R5WTNaSm1qeW8v?=
 =?utf-8?B?dnlRajZqY2U0YnExNTRUdk9GVTlENU1hV2oxVGhUU295N3RyWTJLaFpnL29I?=
 =?utf-8?B?cWtPS2ZOODRWQTEzU2hGbHo2NksxQW1DR1RSdkVPU2xkVXcxa1JUNWVHZWlG?=
 =?utf-8?B?S0pLakZGRUJIYXFTMkwzaHRhMFg0S1dkWmhqZzVaOG1pbnE2dTIrTExSQVpW?=
 =?utf-8?B?VFN3SGFWNHJWT2NQZWFVRVVPUjMxYTgwQnVsVWJUdVhiZC9PaVBKWVhkd0hJ?=
 =?utf-8?B?ajNUZE05SUlhakNpekhTR2V4ZG9OalExd1MwUG9tM2dKYmd0dmRoNnZlV3I5?=
 =?utf-8?B?djB3RnE4QVRpOG5PbC9tWWw2RTdxTmNmVFNGckxCVTRtS0NjcTc0aSs3cHM4?=
 =?utf-8?B?YUR1eU5reXZjcDYxcW9aV1N0ekhRUVlrbHhoS3NmZ2V4QkM3cEQ2Z1h3UXQ5?=
 =?utf-8?B?Q1EwNjhPOVpyM2lxNVc0aG9kSFhrWU1HWS9uT2gva0M0RUozKzNpMzZ0a0JF?=
 =?utf-8?B?aUZxcmYyMU5WUEZRc2o0cHQ0b28zaS9tS2JBZDhLNlhlMFl6OWk0WEpDSG1h?=
 =?utf-8?Q?0FrUgoYBRu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHMyd0YwczAxWEZxcmtoME04cEw2YktacDVCNjZveWFqc3FxTGFwT09ZRXpm?=
 =?utf-8?B?b1J4ZUV6MHRRQm5WeVYxWk8vb0x2V2x1eWlKZ1RJLy9vQUpLYmpmbHltRitz?=
 =?utf-8?B?SS9vQzNEY01EcTM2VGcxZHJtZmpFYlRKUXNmL3NkNjNvKzF5dVgvd0hUNUZw?=
 =?utf-8?B?dzhpcFdsUWN4OU45anNmY2dDUFQ3WGFhR09XWkhWbmkzbWNiaW9XQm9xZ0hH?=
 =?utf-8?B?NW42WkNzMzlRNldnUmdESzQrNk5IS29RaEl2NlZGczRXZTk2ejdoUGphUytT?=
 =?utf-8?B?a0lnRHlXVFRVcmxYTFNZZDlmRUNwN0pnVVF5elQ1WHprY2JHME52bGxjWnpC?=
 =?utf-8?B?MUgrMFB2L2l0c29WWTNTL1R5QnNqMTdvd1l1WHFQWGZqRG4zZEpja2xOQy9S?=
 =?utf-8?B?czR5T2JUaUkrYThYb1ZockZuRVJGWDBoSGFsVkZDYk1tMS9YSTJ3cy9JODdi?=
 =?utf-8?B?eHJpMU5PY3prSTBzUW1NZjIraGc1TzBmSjFRbFUyNmdEYmZXNS85ZUZuVm5D?=
 =?utf-8?B?Q2wxQ1Q0NHN3UE9mKzRVeTQvMFdaYm80UVJ2NzYrQk1OaWc5ZUcyN2NOUk9s?=
 =?utf-8?B?K3hGZ1VsU201T3gzaEVBVlIrQTVOa1BrSFY2K2tHd2RVRHVDQ2ZDOE9HZ3lk?=
 =?utf-8?B?VkNlbEhSZGtJWnlRbFZmaW5IMEZzUjlPYXhvUDlQbit2RHhqK2RjV0FpOVdP?=
 =?utf-8?B?Z3JPZk1Rdm1BS3owRmhueFR2MVZGbFhxK3lnS3lLMW1WN1huUGJHb2lMRXd0?=
 =?utf-8?B?YkZreFlvZHkxSEhYcGlqam9HbzdieTZOK1puL2NqOGFkZ0svcG1IdGRWWUZG?=
 =?utf-8?B?YlJJREtlZE5RcFFvNzZ1bzljNHhYb1NhODR6bkw0SWdaWkhFSFVoNGZad2lo?=
 =?utf-8?B?andnaDBUM3ZGeTQ1b2ErcVFrY1Q4YWJiQ1gvNnIxR3JZams2VHhUcTN0M00v?=
 =?utf-8?B?WVgvajhnOTY4d0laSjdTN1VUdFJ0YUZ2bW96SVdxYmd5bzZoLzBLblNrRlRa?=
 =?utf-8?B?UEUydGNSWGdzTmlsUm90UjRaSVB3d01Wc21wWm0wUkRZcm1TUTBsOVJmOENJ?=
 =?utf-8?B?WDR3Tm1FajNiV0V2YkZPL1VrODRGMkJQRDNEaklwSWNyWFY4UnFZZG5TWUVN?=
 =?utf-8?B?eDc2VDI0b0FNZkJLR3BBVDRxOHdTMU54SHRMR1ZtY3BiaWJyL1NReXNabjlD?=
 =?utf-8?B?Y3RRSnJuSW1FZHFMck1ESzhoMXpKQ0pFSUovaU1QWktBVmRLT2lGWVJQUlRN?=
 =?utf-8?B?M3cvRFBOWTI3dTYvUXRiV0o1WWMvZFhoaWM5WlNiZ2h0anVXK3oyTXY2d3J1?=
 =?utf-8?B?STZuaVNjS08veTlqYTVMN2dkUEhaMFIxak40ajlFTExDb1dOemJ5Q0J6WlNw?=
 =?utf-8?B?NWJ3bXVNV3lMQXdTQ0ZYZzZ4UVdES2NRQjJBVDJ6QlRMZ082bU8vbFhyaFl4?=
 =?utf-8?B?WmJkYmJKcUsvd0g5UjJ3Tk14R0NMSzY2TlZCaFFxeG5pSStySHhYM1BRWVN0?=
 =?utf-8?B?aVNqTTFYZnRvbVRBK2ExYkdSekNScGw0R3J5c2ovTzJjanY0VWQzNEFCY3dL?=
 =?utf-8?B?WURNT3JsZkxuVEtFTlU2QmJCaDVDWWNMb0FZZ2FTZkxIbnZ3Y1Vuc05KSVdW?=
 =?utf-8?B?Y29Ma3VVVmo5VW50T1FTaXZXeWpwTENYL2d6VkdBNXMwYWJxMktHeVIrbWM3?=
 =?utf-8?B?Q05lbS9ENnF3S1pBbG10WURGd0FjbGJCOHR2TDl2M3BHRnBxYXV4d2hhRlBq?=
 =?utf-8?B?RmxNTmJrcml0SzJLRWFadlg5THhaa0lTQW1tVXgveWNrY1RxMDlDREN2V0FF?=
 =?utf-8?B?RTZGWm1DNk02S3ROSVBLSDhSZzBZV0JQb0dUMS93N0x5aDZTZ25ueWxlQSt6?=
 =?utf-8?B?UUJpa0dCN1FuYnpBL29NUTd0azJIRzNIUUNhbXpsT2Zoa3UwTzNuOS9VdTFn?=
 =?utf-8?B?YmE4bTVqOGVuSi9vTS9XWHZSRkdseHlJa05lWUgwclBKb3JiUFFFamJoMXdD?=
 =?utf-8?B?SWN3Q1E1Z0ZWbk05ejBTLzFpbEwrcTJIa2JEZTJORzZZQlV6dklUSjFlcUlF?=
 =?utf-8?B?Wk5LOWx5NklDRDNwRUppbWlpOVdtYjBnemhSVjlQaTQ4RGpZRTdHQ2NKbk1t?=
 =?utf-8?Q?hk+arhdAE/wEOXeB0Gi39/QZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315b4e6a-f32a-439c-fdc6-08ddbefb11f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:12:50.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYcrAOdJK+OTVRL8NF/6yVe/g7ztK5IuLaaSxbxU5d+8TOEDm8z4pEd6JyL9kZf8XZFkTK2LSWIvzIcOXLbUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708

On 7/9/25 03:08, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> There are two distinct callers of snp_cpuid(): one where the MSR
> protocol is always used, and one where the GHCB page based interface is
> always used.
> 
> The snp_cpuid() logic does not care about the distinction, which only
> matters at a lower level. But the fact that it supports both interfaces
> means that the GHCB page based logic is pulled into the early startup
> code where PA to VA conversions are problematic, given that it runs from
> the 1:1 mapping of memory.
> 
> So keep snp_cpuid() itself in the startup code, but factor out the
> hypervisor calls via a callback, so that the GHCB page handling can be
> moved out.
> 
> Code refactoring only - no functional change intended.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/startup/sev-shared.c | 64 ++++----------------
>  arch/x86/coco/sev/vc-shared.c      | 49 ++++++++++++++-
>  arch/x86/include/asm/sev.h         |  3 +-
>  3 files changed, 63 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index 7a706db87b93..992abfa50508 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -319,7 +319,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
>  	return 0;
>  }
>  
> -static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
> +static int __sev_cpuid_msr_prot(struct cpuid_leaf *leaf)

Not sure the renaming makes it read any easier or say anything more. It
does add extra changes to the diff that have to be read through, though,
so I don't think it is beneficial.

>  {
>  	int ret;
>  
> @@ -342,44 +342,7 @@ static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
>  	return ret;
>  }
>  
> -static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> -{
> -	u32 cr4 = native_read_cr4();
> -	int ret;
> -
> -	ghcb_set_rax(ghcb, leaf->fn);
> -	ghcb_set_rcx(ghcb, leaf->subfn);
> -
> -	if (cr4 & X86_CR4_OSXSAVE)
> -		/* Safe to read xcr0 */
> -		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> -	else
> -		/* xgetbv will cause #UD - use reset value for xcr0 */
> -		ghcb_set_xcr0(ghcb, 1);
> -
> -	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
> -	if (ret != ES_OK)
> -		return ret;
> -
> -	if (!(ghcb_rax_is_valid(ghcb) &&
> -	      ghcb_rbx_is_valid(ghcb) &&
> -	      ghcb_rcx_is_valid(ghcb) &&
> -	      ghcb_rdx_is_valid(ghcb)))
> -		return ES_VMM_ERROR;
>  
> -	leaf->eax = ghcb->save.rax;
> -	leaf->ebx = ghcb->save.rbx;
> -	leaf->ecx = ghcb->save.rcx;
> -	leaf->edx = ghcb->save.rdx;
> -
> -	return ES_OK;
> -}
> -
> -static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> -{
> -	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
> -		    : __sev_cpuid_hv_msr(leaf);
> -}
>  
>  /*
>   * This may be called early while still running on the initial identity
> @@ -484,21 +447,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
>  	return false;
>  }
>  
> -static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> +static void snp_cpuid_msr_prot(void *ctx, struct cpuid_leaf *leaf)
>  {
> -	if (sev_cpuid_hv(ghcb, ctxt, leaf))
> +	if (__sev_cpuid_msr_prot(leaf))
>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
>  }
>  
> -static int __head
> -snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
> -		      struct cpuid_leaf *leaf)
> +static int __head snp_cpuid_postprocess(void (*cpuid)(void *ctx, struct cpuid_leaf *),
> +					void *ctx, struct cpuid_leaf *leaf)
>  {
>  	struct cpuid_leaf leaf_hv = *leaf;
>  
>  	switch (leaf->fn) {
>  	case 0x1:
> -		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> +		cpuid(ctx, &leaf_hv);

Maybe rename this parameter to snp_cpuid or snp_cpuid_fn or similar,
because it can be very confusing to see "cpuid" on its own like this.

>  
>  		/* initial APIC ID */
>  		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
> @@ -517,7 +479,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		break;
>  	case 0xB:
>  		leaf_hv.subfn = 0;
> -		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> +		cpuid(ctx, &leaf_hv);
>  
>  		/* extended APIC ID */
>  		leaf->edx = leaf_hv.edx;
> @@ -565,7 +527,7 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  		}
>  		break;
>  	case 0x8000001E:
> -		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
> +		cpuid(ctx, &leaf_hv);
>  
>  		/* extended APIC ID */
>  		leaf->eax = leaf_hv.eax;
> @@ -586,8 +548,8 @@ snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>   * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
>   * should be treated as fatal by caller.
>   */
> -int __head
> -snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> +int __head snp_cpuid(void (*cpuid)(void *ctx, struct cpuid_leaf *), void *ctx,
> +		     struct cpuid_leaf *leaf)
>  {
>  	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
>  
> @@ -621,7 +583,7 @@ snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
>  			return 0;
>  	}
>  
> -	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
> +	return snp_cpuid_postprocess(cpuid, ctx, leaf);
>  }
>  
>  /*
> @@ -648,14 +610,14 @@ void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  	leaf.fn = fn;
>  	leaf.subfn = subfn;
>  
> -	ret = snp_cpuid(NULL, NULL, &leaf);
> +	ret = snp_cpuid(snp_cpuid_msr_prot, NULL, &leaf);
>  	if (!ret)
>  		goto cpuid_done;
>  
>  	if (ret != -EOPNOTSUPP)
>  		goto fail;
>  
> -	if (__sev_cpuid_hv_msr(&leaf))
> +	if (__sev_cpuid_msr_prot(&leaf))
>  		goto fail;
>  
>  cpuid_done:
> diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
> index 2c0ab0fdc060..776cb90be530 100644
> --- a/arch/x86/coco/sev/vc-shared.c
> +++ b/arch/x86/coco/sev/vc-shared.c
> @@ -409,15 +409,62 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  	return ret;
>  }
>  
> +static int __sev_cpuid_ghcb_prot(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)

Ditto here and below, keeping the __sev_cpuid_hv_ghcb() /
sev_cpuid_hv_ghcb() name would be best.

Thanks,
Tom

> +{
> +	u32 cr4 = native_read_cr4();
> +	int ret;
> +
> +	ghcb_set_rax(ghcb, leaf->fn);
> +	ghcb_set_rcx(ghcb, leaf->subfn);
> +
> +	if (cr4 & X86_CR4_OSXSAVE)
> +		/* Safe to read xcr0 */
> +		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> +	else
> +		/* xgetbv will cause #UD - use reset value for xcr0 */
> +		ghcb_set_xcr0(ghcb, 1);
> +
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
> +	if (ret != ES_OK)
> +		return ret;
> +
> +	if (!(ghcb_rax_is_valid(ghcb) &&
> +	      ghcb_rbx_is_valid(ghcb) &&
> +	      ghcb_rcx_is_valid(ghcb) &&
> +	      ghcb_rdx_is_valid(ghcb)))
> +		return ES_VMM_ERROR;
> +
> +	leaf->eax = ghcb->save.rax;
> +	leaf->ebx = ghcb->save.rbx;
> +	leaf->ecx = ghcb->save.rcx;
> +	leaf->edx = ghcb->save.rdx;
> +
> +	return ES_OK;
> +}
> +
> +struct cpuid_ctx {
> +	struct ghcb *ghcb;
> +	struct es_em_ctxt *ctxt;
> +};
> +
> +static void snp_cpuid_ghcb_prot(void *p, struct cpuid_leaf *leaf)
> +{
> +	struct cpuid_ctx *ctx = p;
> +
> +	if (__sev_cpuid_ghcb_prot(ctx->ghcb, ctx->ctxt, leaf))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
> +}
> +
>  static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  {
> +	struct cpuid_ctx ctx = { ghcb, ctxt };
>  	struct pt_regs *regs = ctxt->regs;
>  	struct cpuid_leaf leaf;
>  	int ret;
>  
>  	leaf.fn = regs->ax;
>  	leaf.subfn = regs->cx;
> -	ret = snp_cpuid(ghcb, ctxt, &leaf);
> +	ret = snp_cpuid(snp_cpuid_ghcb_prot, &ctx, &leaf);
>  	if (!ret) {
>  		regs->ax = leaf.eax;
>  		regs->bx = leaf.ebx;
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 89075ff19afa..2cabf617de3c 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -552,7 +552,8 @@ struct cpuid_leaf {
>  	u32 edx;
>  };
>  
> -int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf);
> +int snp_cpuid(void (*cpuid_hv)(void *ctx, struct cpuid_leaf *),
> +	      void *ctx, struct cpuid_leaf *leaf);
>  
>  void __noreturn sev_es_terminate(unsigned int set, unsigned int reason);
>  enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,

