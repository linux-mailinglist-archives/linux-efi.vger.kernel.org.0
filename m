Return-Path: <linux-efi+bounces-5744-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02693C98DF5
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 20:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CCB3A5230
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 19:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A52523A58B;
	Mon,  1 Dec 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0naswD4/"
X-Original-To: linux-efi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA82459E7;
	Mon,  1 Dec 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764617731; cv=fail; b=eGRbIFxLsX8I/ywS8nlG3MM4eug2IR1JEwcwgh2ft9lGteORXVE1R2Eqs/HjwuWiG+La7V89tJsphPqxsc2RKFIqW2wCuLM2sDw6M/DCdrXsvhhT+TIwUGS/ntziaQPLIeIxTu7U0CN8I2qv5CYEVLgEIBwuEuci491b8m7UrTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764617731; c=relaxed/simple;
	bh=f667VKSp78IW4tfJsn5DR9GUmUOIjv1WeJLIGFX9Xm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fAOgb37quUQ5dpE7uitzkBzYRxu/RuxnHjlZCItwDXJAt4NWErgkW+gK86PGj73iTH/zDQuvvfo1Z6eq5u6a24KKkU+fglamfFiPu0haDfsp5yvS6y7tJdGxd9sb8xbQjK5FEpmIXi7XAglicA+4G8+ty+xB0bfwDQvDn5FGC2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0naswD4/; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0tZ3ipzfVDxpgXdNNKAGSuzPbYNbeDpUjphRwpTJnYEpXQDeMOAoCCxCqBcdsiRSXqwHajTm8EpeFIww5nb4BF3bXiyPwp5Zi1bhPChb/iw6u/QeTUsV8Mxt+EY/kZyeN9YttiFzXWVU5Ubcma/M6HCfSPoaIgUc4EfF8wdKubpjEdDSqbSBINWN4+JJ2jlM4v1nCLyzmamNOUwz/4ww+nPWxgJM22618vv19oTBNUnn0cH6ZxKy6ELVWnvIQ6lETRY60bupX3k45S/jVRrR56CDJvOobKslCs7ehySkfDvnACId7skqJy2uWr8ysGkxZ+GGOogH/EHlmTgrZuL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CoVW95YdxZdDvMevb6z/GbRywSEQX7z2fKSQBdJt+0=;
 b=O3bZD/aoTxXWG17/oi2tX+mMWnwmS6c1Un/qFhO3DAZCH3AklQpa3cL7cym6wcU1pc/makgSzJ6zgiW3T4sI4hKrAKZGAxybk3WGmMBGr9GWdyYabqCkwVcIaH/ni8s/MmiSnnrNwYCPEYH2PGuRnz+04CQgCYfM1J166h7xuAOkkHdKlV6WOeNiSu2uWoslW7k/K/1mLAv79Cfx0O8OlAm0vJ427vMBg9QaMqcPWx6CGlc9IMzzPczMYcRwtkrIzDOS0MXO37Mxdo0I1i/qmbtgaBBHuW0UXxMlkMU+UMQN00vy6SLNLMhMoqALQ7rDUwzl7kTaI5AYkWAi0443JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CoVW95YdxZdDvMevb6z/GbRywSEQX7z2fKSQBdJt+0=;
 b=0naswD4/NN8Qa4UH6kSmIOseS7w3nI5RkfrCQ1bRT/0HgFLO/WJupYUCoX9T3FY7OEat5GjYKAlK1xdj89G28kq/WRBuHQJSXfOsUctAUvDmRqVHZuJ5OROfU1Nv25yNa0/Xu0O7FCPYFklLDC0pPGqKsZcu+vFYZufsQ03ejBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:35:25 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:35:25 +0000
Message-ID: <89fde0fd-57c4-4146-82fc-a4c1a56e74ec@amd.com>
Date: Mon, 1 Dec 2025 13:35:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
 linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, kas@kernel.org, ardb@kernel.org,
 akpm@linux-foundation.org, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <ac479414-e0fa-49be-8a30-8f9c0e7b7d32@kernel.org>
 <73a69c03-feda-4c56-9db1-30ec489066fb@amd.com>
 <938a7948-7882-41a3-926b-3d2a8d07620d@kernel.org>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <938a7948-7882-41a3-926b-3d2a8d07620d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::23) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f74ea9-89f9-4b1c-abda-08de3110c677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFQY0YzaHE4RVFWMXFQODlOVHQxcEN5elF3eVRuZE9vMlMzTDBHTUp0dGZz?=
 =?utf-8?B?TGY3S1FyN0NDb0tCY0FYUi9BOTM0UXcrUjZubmgzcnNOeDBFWlZHVnArKzRh?=
 =?utf-8?B?LzFib3NrUjdLbVZDYm9CV2MweC9ENnNvV3JxOE9KTUtqUUR0ZEgvOFREcm1t?=
 =?utf-8?B?VzJ0eExJaHdnUy8xclJwVjZ6eDBXeElqTUkvUHBQQVJja1UzRjF2bWU5eFFw?=
 =?utf-8?B?Z0FZQnlyeWtuMUxnOU5FUXFQSHRLa3R1cW5oaFY0ckw3b0JCR3RsdW8rZ1Bq?=
 =?utf-8?B?S0tsWkd1M1A2S093TzJBOHFBMERLOFJzQ0Yvc1c5WG81WFptRFZxK0V3VTF0?=
 =?utf-8?B?YkpjUmJhLy84UFlLb244aUlhTG5IYklMb0RjY1hTamFvSDVsQ0JtYnFSZnV1?=
 =?utf-8?B?Y3BmVVNVZHVVWjljNUpJNVdmdkYvdlF1bTN3Zms3YXhpTmZEdW1oZWNQTDFO?=
 =?utf-8?B?ZmVDcGZLUTAvQUprS0xIK0FPeGo0ZThXNzVQSmdRREptNXVPUHN2Y0pVMms0?=
 =?utf-8?B?MGVhb0YwaEs4cHpGVi9QUFl6SFhvQnFRQUtuOWVtRFFlTGRMc3VVTW1uTlo5?=
 =?utf-8?B?eXJlVVlLbGJHQUwrQ3ByWHBPOElMRnBnK0VJNnlQeFViWVZYODg1cTVmQ25v?=
 =?utf-8?B?cXlaaDB5c2NpL3RTSVg0cUxPWTFaL1c5MTZvOXJKTlowTk85T1lxL015eTJX?=
 =?utf-8?B?ekI5THh6WkpnYWFRWDBQa1g1TkFDK0FtVUpBZk4xYTBrc0RjVXZtYlJnbjVQ?=
 =?utf-8?B?Y3ZQRFRKVkw0UkFuRk1oZ2lTSWE3dDFRZXY0ckI4RFpxL21PcWU2eGg4ek9P?=
 =?utf-8?B?ZGlxMXZtYzl5QUxRZlIxTmlQVWcxV0hQYTI1WW1aSi9heWtRcHpObElXYzBr?=
 =?utf-8?B?dEpWb1pScGZQR1YwQ0dqQStqcldUZWp0T0FMNXVCLzNLeElFeGZZZ3kySXZa?=
 =?utf-8?B?U21wWDhTaVhmZUlJQ29IZVRvbmFjdUU0Zm9Tb1dLOVl0UWYzdEw2QVF3emZ0?=
 =?utf-8?B?cmZacStnK2I3emZOakVMbnpTRTRzeUNIME1SUHVvY0lrOTUyTFRRbUh3bE9p?=
 =?utf-8?B?TXRwckdZTmNTbDBxMTB2OWg3K0ZPa1UybStMRnFseFZvR0dtT3BFUWcrdlJQ?=
 =?utf-8?B?dXkzN0J1bGE3cUpEOGhKY3JFRUVQR2xmSHhrUzhNK25NUFMwVHkyVTF4eUdo?=
 =?utf-8?B?VnhGZW52VmNnOGg5Z3VYNTM4ODdHM3NqUk5JakdtY2ppOFpsV3Z4cUFTV05H?=
 =?utf-8?B?djlkWUNyWmNqdHNGdjBOSitRSzNxSm50Z2VaSzFOKzFuYStTaUtJM0FzOGFG?=
 =?utf-8?B?U2E0NHVyYmpsTnZiV2lHeGZjTk94UXkybUJ5K3BORzVXM29tRnB3WWFhS0dt?=
 =?utf-8?B?QzdNbndOQ0V3LzV0dVVMZEpmcGt2cGZCcGFON3ZTanNDY1E0NUJqb0RpelFO?=
 =?utf-8?B?YlhwZmsvNFRzd1o3S1JaMUFBWFJUQmRraTFTa2VwcE9YQm1rblVmRGNoQzhX?=
 =?utf-8?B?ZVhFOUhWTG5mSDJWaDQ4bENwM3FLbHVjU21BTm5XNHhmeFNKNVZsMm5adm9F?=
 =?utf-8?B?d0pBSU1HYWp2cVlPQzdqUVhEOXZFVDEyajUxZWJjRjg3YnpHT21aVWRzekVv?=
 =?utf-8?B?TGdndXVDdWloV1RpSUNiellGdE4yczl2WUhqM3c1dEg4ZUxKWlNGdHFGR1lZ?=
 =?utf-8?B?RXEvUlJjcnNDa1gvZzZlWjVQZnlhS1R2N2IrcUNpOHY1U0NSNjNCazd2bm9y?=
 =?utf-8?B?azl0MGQ2UEdaa2s4TVFvOCt4UFEwM1ZpMEdFUmRPVXdrM3h4RDBLQVhjcUxC?=
 =?utf-8?B?UW42QXVuRStWaFJ3RjFOZXRzZXhoTzFaeTQ5TXUvVUgzbzFVWEtLS0dJSnpx?=
 =?utf-8?B?UGpMTm41Mk01R05PRFRBVGVYVy90MXJpY1JVclhaTU5DL0RwNXFpSytjK0VW?=
 =?utf-8?Q?8HSMK1JyzeC/D67DZoyk8Xg/qGC7vIJV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVlucUFiVDZ4aVJVVnF4Nk9WMWxnS05DdkFzcysxM0Yzb2lKb2c1cDBRZXV5?=
 =?utf-8?B?dytPN3g5TUpJQnBIdTl0czdaSjlIOUJQM2N1MWVaMWtkSHM2WlNxRmF3S21n?=
 =?utf-8?B?QjhncTRMT0NpTjl5VGJUV0dNMDJjMlVkZ3QvbWpPQXJpZ1FldTJSbi85UnlF?=
 =?utf-8?B?RUcrdzhza2dCWVE2ZndNOHpWWGNjcWszbTZXZVYyM2ZieXpHRS9zeW1iZWlj?=
 =?utf-8?B?b3BwajBlQy9TcVUxTHNyUU9VSm12RW1lUFRid1pCTzB4cngxd3c0b1hMWmRY?=
 =?utf-8?B?b2QzekwybDlYSjdaSndYcFR4dmRURitjcEhqbnUwMnNmTjZQQnM4bmxaYkZp?=
 =?utf-8?B?c1c1bXB0dTBuc2gzRXBnOEZEeEs5SXdzMU96ZFJPLzdBOWw5WnRJQmFheDYw?=
 =?utf-8?B?VHB5Q1p6azlwZDBqS0hnMlExZlRwcXpDbE9FU2lCZndJWEVSODl4bUwxUFBq?=
 =?utf-8?B?M0FETGtXL1VIN1VURGlCVkxuMlFWR0ZVTlFieE1sbHh1QnRnMC9GY09wTGVB?=
 =?utf-8?B?VXc1NTVLNlVhZFZzZlhjdHd5N0d1dVIzNzZDcDVyZ3FYUG9sLzExdUtELytk?=
 =?utf-8?B?SkZ1b2VBcWp5aW9ZM0VIamlONmRGYlArWm94dVBsdVVhQ0E1cGt1NzZFZHlr?=
 =?utf-8?B?S0NPaTE2TGVzUEduZTBZeWNsU0d2Vm5ZckxZdW1wcjJhL1BMN0Y0bXlEYkpK?=
 =?utf-8?B?NVkrSFdKMWFrcGVqMVlLR3F5ZzkveGlmaXovc29WRS8wVXZSYnBGRzVoQnB4?=
 =?utf-8?B?dmRjdkpwakxCVFR4cDFIS0ZGZ2tFcCt5NzNCelp4cWRQREVIZVU4Ly9ZV0lt?=
 =?utf-8?B?MmF4b0UrM3o2VmlHeGhCeXVReXVXTEpVNEROaGVIMS9ZWW9ZMWFLUGdwK1ow?=
 =?utf-8?B?WGJqSzNPVFVwVXFPNkY2WVBEWXQ1Q2MyMURpbnYzbm9tODhIYVg0M0huT2Vw?=
 =?utf-8?B?dTdsRjlIbkV2WkVRSW1uY2R6WnF6Z1B6cS9NWnBiYlRXZmJlRGtGbVdYRTYv?=
 =?utf-8?B?VERJUGxQOXNkcmxteHhaU1BMQ1VVMlZxTEx6ODZ5WDhWb2tvM2syS1FZNG9a?=
 =?utf-8?B?TkRSV25QQjZyRVphYmw3aEFWRGdZb1M4WVBFVU9ZUDJtcy96K3pXUEQ5VmNN?=
 =?utf-8?B?bGJQanNyb0VhWUZiVWo1MXNLeUh3OVRwa1J4UDQzZjBpQlNDYlVXTXJ5eFQz?=
 =?utf-8?B?OElzRE1ITXpqZEVBQzRNOXZjOFQvRVJGUWl4L08yYjBVSTlhY283YVFGbGVz?=
 =?utf-8?B?bTd5NmNwNkxuK1N0VktLdVN1ODBuZU84UGtkOFc5MUhveld5b3hpZng4V1dX?=
 =?utf-8?B?UTNGOU44NjFUNHVrTUhmTWZocEY5Ym4waVhBQzgyZWlLV3ZVd24yZlBMZmV1?=
 =?utf-8?B?NVVrbGJFbE1NdmRjcTJBcGtQaVM4dmJnUFFDSVdDdWh5WkVzbzB0WFg2cWFl?=
 =?utf-8?B?WFVhd3VLVmY3bDlxYUlRdXpsYjU3cmNZWVpjTWhhWkJRcGtHdGtRMjFJWGZG?=
 =?utf-8?B?VUkvRXMvVnUwdkt1cWsvUDh0YXI3bzVnUjRSdWlSY2ozRmVGOHlZcjlTcURK?=
 =?utf-8?B?N0VDUUJwOUhsSG1BSVZ6V0w2R2lqaWxCNk1ocUwrOEVrTHN3bmswVkFjdStp?=
 =?utf-8?B?cVZLZzlHV3JzZlZnV2VKejZwd0JzSmIyb3kxWm85cUlLUjlzbTRXaFlsb2VF?=
 =?utf-8?B?YlZXamFJdndZUm1GOWpqbVAya3dja0xNTFRJajAzdHMyNUxwaWR0dmtzWCto?=
 =?utf-8?B?SzZlcWx6U3ljT3hYQzdxbE9GQUxsWlJaZGFLNDBneHJhZ2FzVG5UOU9naDBw?=
 =?utf-8?B?TnBYR3Q4TzV6L2NYMExBQnVMZXgxSGk0NjYvbSttOGx6RVdhdFgrVGswTWRr?=
 =?utf-8?B?VkVBMzdROWRyR0tCcFRGM3NBV3dCaDhYTk5HYThPZWFJd0lhVkw1QVRsRWVa?=
 =?utf-8?B?dFNwUnFscmFJYVREeVdHSTFWeWJVWXloSjZYNGRxK3NhaWRPRWtrWmpVY3Rn?=
 =?utf-8?B?ZmE3aS9tOFBZRE9oUmJLeExpaWJqU0Q5YUlsREhKVUpLZC9wUmxVRGgySlVB?=
 =?utf-8?B?dmE3MnpHWkI1Tzd6cmZ1Uld2blYxTWhkakt6enhBcWNxbU5WdStybllyeFZk?=
 =?utf-8?Q?V/NYghgkfhFF7Z9mVIoqE2iv+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f74ea9-89f9-4b1c-abda-08de3110c677
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:35:25.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE6tQoJuoXeUiCO812C56DTIBfyXGai93kF1QLwa1gqwfCGDkhu4G3Fo1lvO8INGsavfEUCOXtAuAYutAWwVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361



On 12/1/25 12:36 PM, David Hildenbrand (Red Hat) wrote:
> On 12/1/25 18:21, Pratik R. Sampat wrote:
>>
>>
>> On 11/28/25 3:32 AM, David Hildenbrand (Red Hat) wrote:
>>> On 11/25/25 18:57, Pratik R. Sampat wrote:
>>>> The unaccepted memory structure currently only supports accepting memory
>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>> reserved in memblock based on the initial memory layout, preventing
>>>> dynamic addition of memory ranges after boot. This causes guest
>>>> termination when memory is hot-added in a secure virtual machine due to
>>>> accessing pages that have not transitioned to private before use.
>>>>
>>>> Extend the unaccepted memory framework to handle hotplugged memory by
>>>> dynamically managing the unaccepted bitmap. Allocate a new bitmap when
>>>> hotplugged ranges exceed the reserved bitmap capacity and switch to
>>>> kernel-managed allocation.
>>>>
>>>> Hotplugged memory also follows the same acceptance policy using the
>>>> accept_memory=[eager|lazy] kernel parameter to accept memory either
>>>> up-front when added or before first use.
>>>>
>>>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>>>> ---
>>>>    arch/x86/boot/compressed/efi.h                |  1 +
>>>>    .../firmware/efi/libstub/unaccepted_memory.c  |  1 +
>>>>    drivers/firmware/efi/unaccepted_memory.c      | 83 +++++++++++++++++++
>>>>    include/linux/efi.h                           |  1 +
>>>>    include/linux/mm.h                            | 11 +++
>>>>    mm/memory_hotplug.c                           |  7 ++
>>>>    mm/page_alloc.c                               |  2 +
>>>>    7 files changed, 106 insertions(+)
>>>>
>>>> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
>>>> index 4f7027f33def..a220a1966cae 100644
>>>> --- a/arch/x86/boot/compressed/efi.h
>>>> +++ b/arch/x86/boot/compressed/efi.h
>>>> @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
>>>>        u32 unit_size;
>>>>        u64 phys_base;
>>>>        u64 size;
>>>> +    bool mem_reserved;
>>>>        unsigned long *bitmap;
>>>>    };
>>>>    diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>> index c1370fc14555..b16bd61c12bf 100644
>>>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>>>> @@ -83,6 +83,7 @@ efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>>>>        unaccepted_table->unit_size = EFI_UNACCEPTED_UNIT_SIZE;
>>>>        unaccepted_table->phys_base = unaccepted_start;
>>>>        unaccepted_table->size = bitmap_size;
>>>> +    unaccepted_table->mem_reserved = true;
>>>>        memset(unaccepted_table->bitmap, 0, bitmap_size);
>>>>          status = efi_bs_call(install_configuration_table,
>>>> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
>>>> index 4479aad258f8..8537812346e2 100644
>>>> --- a/drivers/firmware/efi/unaccepted_memory.c
>>>> +++ b/drivers/firmware/efi/unaccepted_memory.c
>>>> @@ -218,6 +218,89 @@ bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size)
>>>>        return ret;
>>>>    }
>>>>    +static int extend_unaccepted_bitmap(phys_addr_t mem_range_start,
>>>> +                    unsigned long mem_range_size)
>>>> +{
>>>> +    struct efi_unaccepted_memory *unacc_tbl;
>>>> +    unsigned long *old_bitmap, *new_bitmap;
>>>> +    phys_addr_t start, end, mem_range_end;
>>>> +    u64 phys_base, size, unit_size;
>>>> +    unsigned long flags;
>>>> +
>>>> +    unacc_tbl = efi_get_unaccepted_table();
>>>> +    if (!unacc_tbl || !unacc_tbl->unit_size)
>>>> +        return -EIO;
>>>> +
>>>> +    unit_size = unacc_tbl->unit_size;
>>>> +    phys_base = unacc_tbl->phys_base;
>>>> +
>>>> +    mem_range_end = round_up(mem_range_start + mem_range_size, unit_size);
>>>> +    size = DIV_ROUND_UP(mem_range_end - phys_base, unit_size * BITS_PER_BYTE);
>>>> +
>>>> +    /* Translate to offsets from the beginning of the bitmap */
>>>> +    start = mem_range_start - phys_base;
>>>> +    end = mem_range_end - phys_base;
>>>> +
>>>> +    old_bitmap = efi_get_unaccepted_bitmap();
>>>> +    if (!old_bitmap)
>>>> +        return -EIO;
>>>> +
>>>> +    /* If the bitmap is already large enough, just set the bits */
>>>> +    if (unacc_tbl->size >= size) {
>>>> +        spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>>> +        bitmap_set(old_bitmap, start / unit_size, (end - start) / unit_size);
>>>> +        spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>>> +
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* Reserved memblocks cannot be extended so allocate a new bitmap */
>>>> +    if (unacc_tbl->mem_reserved) {
>>>> +        new_bitmap = kzalloc(size, GFP_KERNEL);
>>>> +        if (!new_bitmap)
>>>> +            return -ENOMEM;
>>>> +
>>>> +        spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>>> +        memcpy(new_bitmap, old_bitmap, unacc_tbl->size);
>>>> +        unacc_tbl->mem_reserved = false;
>>>> +        free_reserved_area(old_bitmap, old_bitmap + unacc_tbl->size, -1, NULL);
>>>> +        spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>>> +    } else {
>>>> +        new_bitmap = krealloc(old_bitmap, size, GFP_KERNEL);
>>>> +        if (!new_bitmap)
>>>> +            return -ENOMEM;
>>>> +
>>>> +        /* Zero the bitmap from the range it was extended from */
>>>> +        memset(new_bitmap + unacc_tbl->size, 0, size - unacc_tbl->size);
>>>> +    }
>>>> +
>>>> +    bitmap_set(new_bitmap, start / unit_size, (end - start) / unit_size);
>>>> +
>>>> +    spin_lock_irqsave(&unaccepted_memory_lock, flags);
>>>> +    unacc_tbl->size = size;
>>>> +    unacc_tbl->bitmap = (unsigned long *)__pa(new_bitmap);
>>>> +    spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int accept_hotplug_memory(phys_addr_t mem_range_start, unsigned long mem_range_size)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
>>>> +        return 0;
>>>> +
>>>> +    ret = extend_unaccepted_bitmap(mem_range_start, mem_range_size);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (!mm_lazy_accept_enabled())
>>>> +        accept_memory(mem_range_start, mem_range_size);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    #ifdef CONFIG_PROC_VMCORE
>>>>    static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
>>>>                            unsigned long pfn)
>>>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>>>> index a74b393c54d8..1021eb78388f 100644
>>>> --- a/include/linux/efi.h
>>>> +++ b/include/linux/efi.h
>>>> @@ -545,6 +545,7 @@ struct efi_unaccepted_memory {
>>>>        u32 unit_size;
>>>>        u64 phys_base;
>>>>        u64 size;
>>>> +    bool mem_reserved;
>>>>        unsigned long *bitmap;
>>>>    };
>>>>    diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 1ae97a0b8ec7..bb43876e6c47 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -4077,6 +4077,9 @@ int set_anon_vma_name(unsigned long addr, unsigned long size,
>>>>      bool range_contains_unaccepted_memory(phys_addr_t start, unsigned long size);
>>>>    void accept_memory(phys_addr_t start, unsigned long size);
>>>> +int accept_hotplug_memory(phys_addr_t mem_range_start,
>>>> +              unsigned long mem_range_size);
>>>> +bool mm_lazy_accept_enabled(void);
>>>>      #else
>>>>    @@ -4090,6 +4093,14 @@ static inline void accept_memory(phys_addr_t start, unsigned long size)
>>>>    {
>>>>    }
>>>>    +static inline int accept_hotplug_memory(phys_addr_t mem_range_start,
>>>> +                    unsigned long mem_range_size)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static inline bool mm_lazy_accept_enabled(void) { return false; }
>>>> +
>>>>    #endif
>>>>      static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index 74318c787715..bf8086682b66 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -1581,6 +1581,13 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>>>        if (!strcmp(res->name, "System RAM"))
>>>>            firmware_map_add_hotplug(start, start + size, "System RAM");
>>>>    +    ret = accept_hotplug_memory(start, size);
>>>
>>> What makes this special that we have to have "hotplug_memory" as part of the name?
>>>
>>> Staring at the helper itself, there isn't anything really hotplug specific happening in there except extending the bitmap, maybe?
>>>
>>
>> Right, we are extending the original bitmap and initializing a structure
>> to track state as well. I added the hotplug_memory keyword without
>> much thought, since I didn't see anyone else attempting to extend these
>> structures.
>>
>> That said, I agree the name is awkward. I could either come up with
>> something different, or we could eliminate the parent function
>> entirely and call extend_unaccepted_bitmap() + accept_memory() directly
>> from add_memory_resource(). Similarly, we could do the same to
>> s/unaccept_hotplug_memory/unaccept_memory too.
> 
> BTW, can't we allocate the bitmap based on maximum memory in the system as indicated by e820 (which includes to-maybe-be-hotplugged-ranges) and not do this allocation during hotplug events?
> 
> If you search for max_possible_pfn / max_pfn I think you should find what I mean.
> 
> Then it would be a simple accept_memory().
> 

Agreed, I think Kiryl was hinting at pre-allocated bitmaps as well.

Since, the overhead to do this upfront is fairly minimal, that should
certainly simplify things and have very little to no meddling with the
original EFI struct.

--Pratik


