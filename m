Return-Path: <linux-efi+bounces-2880-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF1A4EDF6
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 20:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DA3173814
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 19:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A424EAB2;
	Tue,  4 Mar 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wopLOE4k"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E82E338A;
	Tue,  4 Mar 2025 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118264; cv=fail; b=opnoeL2B0WNHKlRm6X64ngSKs03OdvOKaoVVEe6ShtXR8ZPeuw4kTjrE7ULEt2F5qTySYyC5RIi89TDB00q/tp9i0YEjYWpHawIv2a843zttZKPDBooiScBROJiMqbKg1KHoFPhsczQPGdNAJSos81xNdoJ50J3G+5fjtdxThdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118264; c=relaxed/simple;
	bh=mvt2z6EhQS4FOfHZUSKE1ibewE1P0PoY1qo2hRL3hHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qFb2kk1QY41+wV6LRI76JRrCHyreWu0OwqeNG8093aBI2D84HYqSrXI5IW0u56FiVgm/uOQ+jj2GC/FkgEqI1R1fWXoHCGAg/K8Hvt3yPDOLrW/lwHd+4JrBUA24zlmWHmYRDgTc/i1r4tB3dugCRcAg1OZxufkVwbwQUywxKZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wopLOE4k; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egoVz8xAt+lhlnwr5RxX8Og+L/xo0zmVawY3dl4ho5leKJdBKc6TCFnSRV7CFT2DLLlI/2cTBxBMhph2RWfee1r1w6EgG6gEYDmuic93VwcIhtxpYQL08t1K3ZatOZ5K7/+DBhGwQOoJ5dYS1ZADjznPFl7HfdCI2FZRntXhe85uxNh0vFTODrvWy10bI6suGT+FR1w9WgLSBh7XO8d/PdjKTnrmqo211qMx5pFwoBgiTx8ShCU/nwf4uoB0U87FOW2zCUp/8+9XAGkOhN/9m7XMkFaU9NWdkBS741tjC5btkytLdxaad2SPn/0JJIeKG11NEMRzqoxcUV9XXwKO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIMo7gj9tOy5QFUHfJT8jS/F0Pkd2Prt+aN/VpXRyds=;
 b=Qi/TPKxaAwg+g7Z3SaT/loc2tZICJjF/uBAfYLoKSzZK3Z/CJhyykSaw6WpYqDqfoaBkFN/WAOoq+l/A8gIpsqDqgZy8ePcb8q1mSlv3b+A040Xi+uXpkQd97H81vl0pd+/E0yPCqrNSkA87gy86n7NGUwoeE+r1od07Kcn9BRecAAx4nolleukIhQL5Ajjlt0uWEmeYpRvCOUp3f3hsHGIcTbZC4BefEkzXNlOBixJTM2iK6KKtS6CRUMBdOtd9vLHg1pxptNT/6WFfpnSIQ60ZIKbD7/v4dndGj0iU9jndVK9sUpkbYBbsw9/UEUD3H9GDxWhFCbzu4wALJms4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIMo7gj9tOy5QFUHfJT8jS/F0Pkd2Prt+aN/VpXRyds=;
 b=wopLOE4kjyxEf6UbnC6RGFWXqzAHurAM0nObm0RE3whY9sJeTlBZInQxonFCSk9oNM0ECQhjsNeL+8tV+4DxHKpp2xLXJdlLTbxT2JGNzCWfHRcEcEtZZs0rINxZPv+ixQGu0mWlY8DVxm1K/L8hzYjIcmz2zzQwA7J0BHxvRig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 19:57:40 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 19:57:40 +0000
Date: Tue, 4 Mar 2025 14:57:31 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v7 1/2] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <20250304195731.GA1960804@yaz-khff2.amd.com>
References: <20250226221157.149406-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226221157.149406-2-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: BN9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::6) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 8932b0ea-4e13-45c6-a69f-08dd5b56d20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kp0c7JqyuwaZ9YewNhGlMkLPBv55+Mq5zEiimoq4ZW95fKKdWdizWC1lOI3t?=
 =?us-ascii?Q?/9dcdDgtdlX7/isViYcvXgcwSCU82+hNXPW9kN7Nt9/pwpGTEob8ZQXD/KdN?=
 =?us-ascii?Q?uZDazjV+zmauSYeYe81MhFNC6x7UVZDWxVoFpZUSVYaOkDDZTQ+iuV4z0074?=
 =?us-ascii?Q?CYE133FHHKDV4Nq7s3/Upxhc4By1rF0+aV7fXdqy5pITSFq1CXH0rCLXWP4C?=
 =?us-ascii?Q?aga6ortKp/9RSwQOLx6SlHQD5bRU/pAE68dI2eZHl5/USK3LM3QNFeoSEbKF?=
 =?us-ascii?Q?li02i72I8G+ZSuFYgJFAr+igoiHxY0SJVllbk0klwjjQL5sQkOtZsM+sC+me?=
 =?us-ascii?Q?lFzE3pMJaQ3WYTlxFryMivRaAp6tRHDx9qLu2yfReRt6KRU9r3MTCOUbTslZ?=
 =?us-ascii?Q?Kx5MIzwFI24c5gTuS3qQrGb5YjAZwxpG0MQqvBECtDfTSOnAeGNWCmCuVweP?=
 =?us-ascii?Q?yEVNxVZ9h5LJce5YBmvOTWoR92mp9TEER61Y0EAqjxkxe+O75hIeBMu9L7lv?=
 =?us-ascii?Q?O6MCpefAco6cQGVWrWfaUPMyyCwILKsFCP3n2jKXqpYNfkpf0NGIXI1/xlD9?=
 =?us-ascii?Q?4Ftvs+i78bxSjzUqz1T9lAXliSxO7zAWVHcT5WWize4JMA9JE9iEn5AbwctM?=
 =?us-ascii?Q?NxJbKLKt0s4rw+aJZrK5wbzbgMUvNwWOxuV89GVwyfY1gVxL8qDO7PqAzLKi?=
 =?us-ascii?Q?n4KXTvMFrOBh+fxMSZeHjRFvAjZIakt0GnPQuz7Rx5qRd0tdBgSMiyvTdsLJ?=
 =?us-ascii?Q?wzOIS7bfYwQomxkDbopyVMgN+zqhmDIq7snTcNs8ZE/Nf2Btw88hLonEe7yO?=
 =?us-ascii?Q?McXfp+QKJDX5LqbxIpDdhGivFm24XgMfyro6xspA/zEbGzVNJSfJ6GF/B3FZ?=
 =?us-ascii?Q?yo/JnprGiTebmZ+mfjUuDq9xU1mgNRE5sm/veQkcfCc5OMKNuwjonIb6e2pn?=
 =?us-ascii?Q?lX5oDyBbWLhQtH2ou8fXRYE5DK2JKtfNIYaAJE54iNReeL7OBnHTVKSBOSHj?=
 =?us-ascii?Q?cT44/EDmn8c4umxxBYA8JhcAe/n0sL8papkw9nPXkISVk/3LJ+PQGP3qy0Mo?=
 =?us-ascii?Q?X99+n9CqUTChvPFxr1B3R5/KcfVW6euBp/ikJbhJteWcg7P5r00e7VIeK1lZ?=
 =?us-ascii?Q?/tMCWVz2wIdq2Jeilj3tMtuiRtEkgsYOP6z4FciYcgyuPHMiMvFxVszQ2kzn?=
 =?us-ascii?Q?xVlNOhkcrE2nl2qMKUX88kvr1w8ZBpfd5Ak8YKCoaDfN9muOoqGuPJY5dFon?=
 =?us-ascii?Q?ZIigfgUreh3JOU6U+d6uZES0DNWK4EiNimAmV3AE1ZXF/591dvI/OLLKKyDN?=
 =?us-ascii?Q?ubn3Z4DLcs95084T33AO8NkXamJY5kB2znG/wG51AHcYLx4fX5cK9pnI5NsY?=
 =?us-ascii?Q?jFm9Dsuy6H8KKqDu1eAPv9Mlw5TA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w/ELOCMAst/5OctmpG3sHk2T6d/9Ar06JfACpE7iZ6RSUXTsmv7tyVwPlHVT?=
 =?us-ascii?Q?WD/GOUQlu0LrqpylquL57HLO8xrZ/3WWfqZu7kZRBUIbFjgsmFRxLiqQEBm8?=
 =?us-ascii?Q?ynahvDtDpjlzaio8p7G9pt1xxDCLe8bZ0F3KjNN6FqMWwQQ6L/c5cRCucW8X?=
 =?us-ascii?Q?plEIVSN4JyUdRn5nBLXYgh5fU1yUvrVOr7LmN+Zjk6ZYpM9PkUgj+lPkbZOy?=
 =?us-ascii?Q?/8LJ/yDymc5mzFhwVkoBuVOyfXxAJUyJmCNvrCXRripwXbsGh37he+Ik8H+y?=
 =?us-ascii?Q?47AFQPfdquBWzAXX1JDYw352nyPv4bhC2JzhIDTlQsf6rfCILUKkoDoJXo3o?=
 =?us-ascii?Q?x5V19TbLoNUHlbWvDlALhm37GseJj6X7rkPK+1OEpPjexv51R+YmRL+TiMVH?=
 =?us-ascii?Q?hf43a8+fTxXzBFE5+z9bV15rOyiV057Gzi2pd57+ecuwJ3WmpZjUaLiQrjJ5?=
 =?us-ascii?Q?2XVEAkU9fGvSzGDSLPiUcu0bXvUReTGR2xIgHAhDPoCu3x31BunK4BiKFwj8?=
 =?us-ascii?Q?dg9oOnMIupWYN4CxLLT1kCrBQjfGoSPAXHAdBh1lkkTYVcW3/SvmYS78m6Rp?=
 =?us-ascii?Q?nvsnP1jYAc5RqF7wzbMm9MOL/dWC+kfW1FMb+hCIxXtlOkd7H5G5bPWJozxT?=
 =?us-ascii?Q?8Qoyt8b1/mcvucZ3nQ4V34yE8WgtSh4i9rZUV0Q5r0ZSsRyAaieGq2OShDC9?=
 =?us-ascii?Q?/r8Kv2XtVoEZ4B2ErNk/w83DxQoXPsGXLTskAlH7e7HA1TJyANCdirRmxCqW?=
 =?us-ascii?Q?8kGILpT2mrxye82jeuoEkv4k4/QDAS1KXCBkL7cGQVieH1/p22XHnHfib9mu?=
 =?us-ascii?Q?hpPIEp9/8tLUmY54QhuC9HKj2s8nyzKqhdvtIb4ThZa1wXpKxEuvwRwSN84+?=
 =?us-ascii?Q?zYacSnUcaDWjnGnEFd57z5/lR0lqtP4LEkbY4O1iNFC96Oxfcfe+v15ZWnQr?=
 =?us-ascii?Q?2uoFeLHXBKInVGEh6MXl/M3TBkKt9+/Py7IwNZO8LexDq+cHPOnpTnj/VsBU?=
 =?us-ascii?Q?D51WrUKSMDLh6iU2vuvE98vnomKrHKtGjdQ5+5Hp5rK8ZkysN9QEX4q/UXF/?=
 =?us-ascii?Q?2Fubu4jFjhcZ9gOgSQKvAHfdYM4Io6Rcpd8p3uUMz8J9unezUk5gvgb1A31T?=
 =?us-ascii?Q?BR2XzbA0pCfptbyEs/weJXGi4SxOw43uKsrHR6ueZe0gGj0lHLzIp0Pr+vYE?=
 =?us-ascii?Q?QccV9crTP0k35HCHMJ6IRlmkjl2Glu/yRjavkcxIdHDsPpBeuLwppJ14nG+j?=
 =?us-ascii?Q?DVO7uAyYSaQMBPrW4yy+C2RquUirCyDLMLozdoTUr7NTNyUC3moUuh/xzaH6?=
 =?us-ascii?Q?atvjFJG7neGYNHUJ52vd0T1MAm+AmcYFyjpMkVKKxhXORfPUgb5jtfsJeNtj?=
 =?us-ascii?Q?n0dXU57I1942IWbSEMZusFkf4NHufgQGcbTBAC9enAjvVkwMcZ0AZcjP0L65?=
 =?us-ascii?Q?wIK4SQauzJvuyO6gMXH+kYCwEOKI1CtxWbjrw3K4mPJuf0Cj4/kT9HpayC9b?=
 =?us-ascii?Q?VRPnAZf3DNQklgHJo/NGgIgz/q9muNSBkq7bZTgYiSQMb8qZR/72G5odWHcE?=
 =?us-ascii?Q?02Tkwjs4y5I27AU8j1sCwLUBrLRD76EAvq06sH0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932b0ea-4e13-45c6-a69f-08dd5b56d20b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 19:57:40.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84xNvw08QZvBYF1XMTnXNzdZvLwSsogLIRGX+zR3tH8lrtp3tMfHNf9b8vMMmqEcjchjC2JAgHNXYw1AmGs6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8

On Wed, Feb 26, 2025 at 10:11:56PM +0000, Smita Koralahalli wrote:

[...]

> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
> +{
> +	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> +				       data->prot_err.agent_addr.function);
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
> +					    data->prot_err.agent_addr.bus,
> +					    devfn);
> +
> +	guard(device)(&pdev->dev);
> +	if (!pdev)
> +		return;
> +

If 'pdev == NULL', then there would be a NULL pointer dereference in the
guard() statement, IIUC.

So I think the guard() statement should go after the NULL pointer check.

Thanks,
Yazen

