Return-Path: <linux-efi+bounces-1954-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E612D99B6D3
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 21:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1841F219B9
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 19:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6218453C;
	Sat, 12 Oct 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9uc4Um8"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C674418;
	Sat, 12 Oct 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762607; cv=fail; b=drcLz+nH5RTs6iH96b23r7/Qr99gCFP4S1Nmex6ppYd4MOzS4FjUa1+Q6RsmZfnWkEBYJ1aXZgBg5Gwtb7Fdv0b5iwOD1yJdPaU+iu0UCbV4hsZGhA4eTnLa7RYCwiVdPbE5AqQRtpNw5g1eqUHqKYQ09Tpx9sKaLC1xlixO9kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762607; c=relaxed/simple;
	bh=Hncbj9GXZ+rdvO8QPLOJZEe53uI7Qjh1wdNyI39ga3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/yCeXzBtByKyIozvQxTVwSlrBdHsOT8xbHShr6GGP7rpmGzpPu8aldEqg/XmrAZo0EbWfFrWaxF+IscQd7Kt2+S4vORPbfjncr3kE68l6P6Ewn5SlAfJVG/lkTgI6wXMizYMQfEjfb5+RIeqTyBzrDWsjgMdx68or/y33FCAJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9uc4Um8; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXZvMIESzCwUAvUN6QqdkwVdLwhcjSylX7ofbLa95J58PamRj36u2r4Nw76jQYRrL93aM/y4264Llyw3iL3pidfuFk6qrl/9Mb+iOfd9bHWxabgXmTwmdLbNsqxIqdyoUyxaoY7Bvh6P5hKX5qYTZeb9rZKCXDzjReexHeX8mLfTQ/L9j9INDsbvFD6BrjbFsJNJ9DGfnu8BE1xIBaeYvUp1oTAsim3WJhUYdFy9rObyaa1Xjx8TdOGEFubmaBQQHvDyaSVXAgSovyZmXQ7/HEPBOkdxxfTiwkzK71BdsINI7P6gn+scYSl7k8EgXHGeIcaxWnXwEjUgQ9Cfna1esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfRyPl8ndBEbRgrIxAcT+brTHSaZhAzMrm4g8JPez4g=;
 b=LYSCi0XUK9/RWdLA5V6lnoXA63UZ9g4LGxZmr1XoOGCSExEu5poA3V6Aql8LPNWKqpkPeN6/WXjaGc5ffQ8r3i0SWyQcVheb7KxtZeDOI9mmPUTsDpfiFmMVtRVlWLV+Lxd5D0ApbhXeRmDYqSFggHE8yHdF9ENB+V/7eBjN7QAiO5LJ/qkMAzRxmByUOYXbFL6s2ZOR7aLeQWoUsVMdHB4ak4Hf9+TTb52reZqP/LYxlIQI51QhlPuA9XJjDbt9lx5pcxhbYJ1ty6NuIgs3nlVSTM1Zz6FsFYwRUp9Q3O9gT0ZGc4Pc+z4Qm0H6w1IuKloOCkYBJEhFfclsMZpAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfRyPl8ndBEbRgrIxAcT+brTHSaZhAzMrm4g8JPez4g=;
 b=B9uc4Um8qC+fUcinDTsB8bCZgbffK0mMHzMsQUsAIBnPQ0vyB9XiAiNk4P8rpj/1qv3zW0Xf9YCuDcYjmMIZS9LEM5p3REi5v/UHw2ByVSEI9gzkooymy46HpOITRr+KKMv0o4JPPr7f+Q1J3bw7bgL5imnzm6NENQ7iqMTXbU9MYi3fdo5Nym4qbhH2OzVs1vEFQcl4rYAxv5z45HgtmJYTXhAI2AMp4h9NTPmyc8IpW0+lI2S6n3iIr0el5PcuPbMUlmvxNCAfqO9kV0+08ftcsbDB4G+VD04rGAyoXDAPHWDvlsh5LOKEQaxpNdQbD9uS1PsvCLWPQcec0yOV9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 19:50:01 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 19:50:01 +0000
Message-ID: <6a08b06b-5672-473a-9a0a-7068da5db0d1@nvidia.com>
Date: Sun, 13 Oct 2024 03:49:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9] acpi/prmt: find block with specific type
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-efi@vger.kernel.org
References: <20241012194210.3588557-1-kobak@nvidia.com>
 <CAMj1kXH6Q2t6ER3kZDtiAFmk6QKj24_LtV9gjfq3bjQCBAVSww@mail.gmail.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <CAMj1kXH6Q2t6ER3kZDtiAFmk6QKj24_LtV9gjfq3bjQCBAVSww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0364.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::9) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaacb3f-b54f-4cc4-aba8-08dceaf70f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkgyeEcvYldXcEd0bDhMeDRaWVptUWRpMm1OdUhRbXVWc1dyKzl0eTZJeWVn?=
 =?utf-8?B?ZEtncXhvd0dRN0V2WklveDg5MUpUeXlOTlpDYkVmZ2NOeElVRTV1VlQyUURs?=
 =?utf-8?B?bDFUMnM3Rk5iVURLYTN0ZmE1T0dkNUZ6TWxMS2lRZ1lSWVFQMHIwS3JKalN6?=
 =?utf-8?B?ZTJqeDc5TDJaeUtaMEpBU2VVTVdabE52T0FieGFEaEFRK2ZSYVRxUjZKa0hS?=
 =?utf-8?B?TUxId0FCNExkcGhWOFFUUWQ1azhZKzNnQmVoOERGMEpWWE41M1hyb0ZWRnFK?=
 =?utf-8?B?RmNiZXozaHZqcHBFMU92V1dqZzJYZjFURVJIRGt2eXNYU09wYzd4ZGtJeEh6?=
 =?utf-8?B?WHBUOXlnb085ZXdDemJCeExuTTdmM3N1Y0s2RjdVK2crZUxDN1NUZFlEK1N0?=
 =?utf-8?B?bk05QnpGWk5OMWtsVFF4VmxjYmNLTjBibmRieDhoVmtST05ZRmJnTlhRT3Ez?=
 =?utf-8?B?WERnWkcyV1NNRERvVlh1RThoVVlmUkRzVDBrSUlPWTZsN3Q5MG5peVdZS3Vh?=
 =?utf-8?B?cG01cG1DU0N3U1FnZi9tQWJJMlBiRDMvNFpjZ3h2TURQRG80ck13UWZrTnd2?=
 =?utf-8?B?Q3J3bktPVUhsaXYzQXNjSlFNa2ZScmtSV2ZLZTlONDk5dklFaXBwMDdrRDFo?=
 =?utf-8?B?ZG5jTkNHbmc1SlZueHhRa0NUSm9MMjNmTWhyR2E3WVlEK1hPWTRCNGVndVVS?=
 =?utf-8?B?ZVBySHJKblZ1TkYwb3gxZXpGVEo4NXd0Y1pXWVM3NDMrMlovK1hFMVllYU9C?=
 =?utf-8?B?TzBIcXcxdGV5ZkJnMTVHTk5STjdxZitab2Z3ZHJFWmZZMDkyMGtrY2RmZnpq?=
 =?utf-8?B?UHNGWHBwYXV1UWlQVXpsSUpMemNkcyt2Rkk3MVdyRnNDTzM3cEJ5L3ZsK1B5?=
 =?utf-8?B?bFZ5MU5qWkttUnNWNjdNNUtFQzJOdVAxdk1DUUtzRkNMdnYzd2RWY25sZzI5?=
 =?utf-8?B?UFBPRG83THU0Q2xNVmZsYTF3Z3VXUFM0d01yWEtkaytRQW1TQmFUTkhSd2RO?=
 =?utf-8?B?QVM4RTNCNmpCb09zN3drdEs5N1BUcE1ZcGV1MlBQcXJxSkE5aGpXZXZFWC9n?=
 =?utf-8?B?L3dCL3JYZk5yUk9iaE1JSVNkQmRINlE2V29BajFpb2c3WnhvcnRBN0UzZml0?=
 =?utf-8?B?WTlXZUlDVWNvOEp1ZUlWYjNkQ3psWG5QYVcwQ0tEQmpuWlpSd2ZOS1Y5Nkcz?=
 =?utf-8?B?OUFXb2VISy93T1hoNm95d1RXckJBWk9Sb2wyN3Q1R0E2aENhd1NZQ1AxdWRh?=
 =?utf-8?B?NjVXaDJJV0l4RE9qLzhaTk9zV05mMSsyYjRJenprL0RXSHJWZ2RFNFdiTE1S?=
 =?utf-8?B?R3NhdE1KNFhPekhsTUJ2SUQ2M2x6RmwycUFENjBtQW9PRXhKOUE5SVg5Q3U2?=
 =?utf-8?B?czMxMnVmOFF1aWxhSDUrVkJUYW9pbTFHWUUzOWxQdVhjTDQvT05iU1NqK3Zt?=
 =?utf-8?B?NUNFRkZDWGFyd3A2TWNwd1JYVlhQS0JSM3dNNVRnUnpPN2lKQjYzdFQzbUtE?=
 =?utf-8?B?ekdPU2tBQ1luSXIyems5WGwxN3BmSktDREt4TnYzZmxwWmU2VUxVODFBNU1C?=
 =?utf-8?B?a3NPaitkd1FHOEFUM0grTUR6Wm1Bcmw4bnQzZGFLTlA3YjhSSXJCdEdCOE1K?=
 =?utf-8?B?bnRVMVZZKy9taEQ0Y3FMSGNiZFliOHBoMlVtSFBUMzlhNnRRU1FyU2lvUENM?=
 =?utf-8?B?VkViRmhKZk1KVlB2eXhGWkFpQjFpQ2I0ejBXdzZKUThoMHBOSGR6c2RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlluNHdHSVllZnZDZG1rbFYwdmcycEgyTkxud24waS9IMS9OOVZHZHA4Q2Vq?=
 =?utf-8?B?QmhxbllwZUErRVR5dHNwb3phQmVKSUU4NnNqVkNvbnVSb0pVS2FDbWZXdkRk?=
 =?utf-8?B?R2dnWTZKb0JsUEtrdUF0RXlPTnVrWTAxOWF2cjQwWGtSZVpwejQ4V2t6TXY5?=
 =?utf-8?B?Zk9nMDZQc0tBeWV0eTEzZ2ZDNVllSjJBSUxDck0xNG1ROWdlQ1o2ZVRzbisr?=
 =?utf-8?B?T0RlQTZ3Umk1STRpS1p3RWRjZUVyLy9ISjdWVkt4U1Rjayt5Rk9EeWpGWCtR?=
 =?utf-8?B?VjlmczIrZlBEVkpRWkFSaDhOakhGdStFLzlxblBzUW80Y1FnQmtYZ21HbTU0?=
 =?utf-8?B?U1BFZ0t4Z1VZblZKYjVadHJER2RDYmhybXR4c0wxTEs4bVpvMlQ4NHRWbWdr?=
 =?utf-8?B?N1oxM081U0pMdzN0L3c1ckM0WU95alc4RS9SaDRWMnNSeEVOQ3liL0xXNG1O?=
 =?utf-8?B?MnR5Nnp6RnJBWVlFYU5qL2FrS2VuY1JpMG00N1QyM2szNzlLUk5wYzJsN1pz?=
 =?utf-8?B?L3ErZUxHKzMvb3JOSytMbEFRdlpzVkx1NDVwNElPbEw0NnQ5Q3BrYUFVbnlS?=
 =?utf-8?B?ODJWS3pXeWI1WTFOdkdOWHlLR1hRSmRrOUJtZXpkQUt6Z2sxdytEQmxiNHY0?=
 =?utf-8?B?VE9Ibnk3bmFJQ0thYk9OVFcya0w1ZUNlYjl0dnRRbFdmcWN4OWFxTTQrVk5E?=
 =?utf-8?B?eWpBdi9DcnFWdEE0MlMrMjBHOU1SYUtYS0JLaEJrTXI1ODJhSHZDSlQ4M09p?=
 =?utf-8?B?T1kwcnVMQ1ZKOXFiRzQzb08wanhWQ0FoV1RYNXhiRmFYR0V1dWNuazluYjNy?=
 =?utf-8?B?SHN3d2VWdnFUMU9WZFEvcnBFTzZ0TW5XYWwvc2RaT05RZTJuWTlGSXlzdmw0?=
 =?utf-8?B?KzYyaytPL2ZBYVBXYm1RVWtQSm5iSGpTaTFud3U5WWEwaWZVRjdkazhTbEtU?=
 =?utf-8?B?M3ZEaUV4Y2ZnVXpVYzhFV2NiMm5Yb21qZTJlTnJzZUpVMUNCR0RHU0JFV3Rm?=
 =?utf-8?B?Zyt3Z3JrM0lPeHZ4azlPUDdQQVRBYmdCcExJZ1hzMDB1aFhVeUl0Q2xTb1Jy?=
 =?utf-8?B?MlpHVWJCdzN1L0ZFWEVKM0pWUGFQRjFUbUQwTjA1OU9GakxMQ2YxQjNCTXpY?=
 =?utf-8?B?dmRUWExESWQ4dHJHaEEyZ081T1NxWWtpYU9GcUVqRVk3MEkyK3JNajBQWWtr?=
 =?utf-8?B?OFFJMFArMFhlU0syM0xKcmpRUC82TEZiVHZXbmRCdVhnT1c2UnFwSkNMTXdJ?=
 =?utf-8?B?b0FYcXJpL1dIRFp3eThUcjh3MGFLOTVaSWRheDNjUW8ycjhmSmdNL2JPM2Fw?=
 =?utf-8?B?L0NHVnczeEZrbDFkWFA4UmN2ZUFxelFsUUgyc0xzOFhCL2x5SHl3MHA0ZzBD?=
 =?utf-8?B?SnhQekVPTUlzNTluc0dGbWtpTnZSUDhmN3BYWUZoUDZvRXVER2JKQ01ORVFs?=
 =?utf-8?B?MWFCZzRyU2sremNNM3pXSGYxMmk0dTFTK05oa3NKNkFZOVlWeWlkYm45ZWRT?=
 =?utf-8?B?UjRPNExjcHE2dk1xaGV1L1RiSVVxMDNHSUlxMWtzOWNOTGxTWTI0NFNzTktl?=
 =?utf-8?B?TUpOdFl2WVdkMHloa01mcmNSN2RiS0lIU1BCbzdxRU5YU0R3V2IwME5CZk1j?=
 =?utf-8?B?d2V6VVgrc21iL3RzMGN5d2Q2VkFKNkpmK25pVmN3VDJxQU85S1FncDBiRHVT?=
 =?utf-8?B?dm8wNTE2ZmN2V2tCUExIYlVzVXlFYklWYitPaGxMd2F6ZzNPaUw4VUx0ek85?=
 =?utf-8?B?ejBlb2M0N0JtdkxpUHl2NnRzY05ZaXIwSERRSUk2ZUN4cTljVjdkOE5MVDU2?=
 =?utf-8?B?VFp6N0dEcGtIcFBhYWtSVFEzanhsb1JJQmtxSkZUa2k1ZG9ndUdCZGV5Q2Jz?=
 =?utf-8?B?S1BFUXRtMUtOblpxQWhBTjROWEFkZEI4aUNMUnZQNUczRGxPQ3phdmdUT0s1?=
 =?utf-8?B?ZVp5SXEzNzBHM1RVU3kvL1RWYzVCN1NiTGUzNmR3TFhYOTdlTGROZE56ZGZ6?=
 =?utf-8?B?dWVsR25DYzZmcGhtTU1EbEV3MXlXNWhsQW01WTJmdE1NQnRON0VrdmM4clQx?=
 =?utf-8?B?TXRtOWIvRSs5aUJuV00ybXhVd3BFM3NPTWJhYWRHWmVieEtPdmc5T2M3aGsv?=
 =?utf-8?Q?dZJKqvPGi0w8BoVe6qsr6+V3x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaacb3f-b54f-4cc4-aba8-08dceaf70f7c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 19:50:01.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jng6ObGEAXi04+mMCJjidtwkFkoQgpFdPPfl/JNuqI2elMswB5Tzxjfy4ILLc0ZW7Os2O3seFdypqhGAzhgIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222


On 10/13/24 03:46, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
>
>
> On Sat, 12 Oct 2024 at 21:42, KobaK <kobak@nvidia.com> wrote:
>> From: Koba Ko <kobak@nvidia.com>
>>
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of
>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>> runtime services as described in Section 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is
>> a type of runtime service, this causes an exception
>> when the PRM handler is called.
>>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>>          __efi_queue_work+0x11c/0x170
>>      Call trace:
>>
>> Find a block with specific type to fix this.
>> PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context.
>> If no suitable block is found, a warning message will be prompted
>> but the procedure continues to manage the next PRM handler.
>> However, if the PRM handler is actually called without proper allocation,
>> it would result in a failure during error handling.
>>
>> By using the correct memory types for runtime services,
>> ensure that the PRM handler and the context are
>> properly mapped in the virtual address space during runtime,
>> preventing the paging request error.
>>
>> The issue is really that only memory that has been remapped for
>> runtime by the firmware can be used by the PRM handler, and so the
>> region needs to have the EFI_MEMORY_RUNTIME attribute.
>>
>> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Koba Ko <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> V2:
>> 1. format the changelog and add more about error handling.
>> 2. replace goto
>> V3: Warn if parts of handler are missed during va-pa translating.
>> V4: Fix the 0day
>> V5: Fix typo and pr_warn warning
>> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
>> patch
>> V7:
>> 1. refine the codes and commit description as per comments
>> 2. drop goto refacotr
>> V8: Fix 0day and cc to stable
>> V9: Describe 0day fix
>> cast PA as (void *) in pr_warn
> Sigh.
>
> Please read to the end of my previous email and fix the other thing too.
Sorry, I lost that.

