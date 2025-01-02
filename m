Return-Path: <linux-efi+bounces-2496-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD09FFFBB
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2025 20:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74643A2A15
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2025 19:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D41B4F0D;
	Thu,  2 Jan 2025 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YZozPP1O"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBA38DD3;
	Thu,  2 Jan 2025 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847776; cv=fail; b=ZPyOAzy/qVm1V04+I51L2Izvw94QxjqCsqbswhq8m9LBGhCtXS7ZXXxzugNo+0ILr+mmcQdVlX8dhjtMojXzKvkItouERNGyqahNOc8gegYxQvcY8DmXUGtrZWgqa5M4gogT30kKhWxi8eUnZ3DZNABWYLJOL7SccO2zF4Lvpf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847776; c=relaxed/simple;
	bh=ffzj4+bTQ32Irxkn94bNxalNxg+6BxDLCcVpyYjUeWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WrtYAIQaLACBmUV7cJwIUZoUqdLhJfoDPEahoC89+d2nlL4xipRGogF5v7s0rOc9ubSEJsXMkNrcf1YwSRQJ+cy0KrUHihKdnjAk/8uBws7Alus1OdN14AZS4BaN1PMecoH6JdRNendq6ZviMStSoWyUz/VYtvsn/JBPgz8ol1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YZozPP1O; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIQn63MJBe/TrangSFGeb+7qaVeC4dIup9hLqQU1SgrNqgKaMpEUfVNB29ccrXELLELT/4fFrUkxVQ1bu7l5Ne43ywK8+gJHOzf3kR8zg4JcmkUlqa2wm9RlWGM3yQw9GiIk/RsKaapk6ys5Uvhmqf3hx/fzfs7sYSg0OKZJoQ4miE9b0tQ1EB4AYmR9zRqWz1aDLM0uNX1EVzKvQ2hBhMLBudzEzeNoLZgmMUda1i6LMEhOdVvOtrhVp27kRGvj3GGwCOuQtWhK34BWJCN8KlQb3niw46PYHQoA5FqcJ4HkdnIgExlYX9DQnqBbJh235Kb+V259F5SPuhLcOQe3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8iMt0b4Sq0V1Qj4xsB4dSWkgKbSlY0Q6skTMLXe8mI=;
 b=LrDJp0JAMDbNF54W7RtqS+k57cx3g0zJuB1hPg6RPWtb3j+CxWb8Kf7qzwrdiZnbDwPefEtHdxqKFD8UXFuHjUdptMdR6ZSUweU8KkzgBH5lXDEZACeQdrcALT/YJCSeDDqLDpcq5xOd83f9z3ep6JlLNkBd4220byLvKZZKb6TIbJPYgVQU+1WzNC0lb3Mgtbd/NxEVdRJesGnnVd7MuRssmsScj+qpEHbj1KT9JPOZhJNwtVjNAXJwuiJIw49ztf7bN/HjkTf0wCetaOC627+CCI4xwxzGrFW2kdsQUYjXicOECgm2jsGrae023XU93GD92kmIQsZECQ30B/yzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8iMt0b4Sq0V1Qj4xsB4dSWkgKbSlY0Q6skTMLXe8mI=;
 b=YZozPP1OxU1kL+AlHNadbxB1Yyw7Gz8RNhBe8+2JZipWucGS9Sl7TIL+Nou4fdox4Uy2vq6n7dgwMPPqYTbIAwudD1MP+JgsCwYk4JWjke+605uKfigdo/Bm4Yv7emiP3AAk1ZWh3mhXm+ZsGi7BkiBfCMm80pf6pCDbAIPYVf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 19:56:07 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%5]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 19:56:07 +0000
Message-ID: <2e37e889-ee70-48a2-8d3c-379e66a4519d@amd.com>
Date: Thu, 2 Jan 2025 11:56:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241217022032.87298-6-Smita.KoralahalliChannabasappa@amd.com>
 <20241224181457.00000e0c@huawei.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20241224181457.00000e0c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1759cf65-ee29-47b9-0ba1-08dd2b677f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVUrOFBEWll5N2pqTjB1TlpBNTc2OW1sT2wveSt1MEU3dU9ZWnRocE9zV3Fh?=
 =?utf-8?B?MVBsV09XM1U0eG5yTlNXekxDQVJ3M2N4cnJqSkczNlpqSDd0VURUVTNjTE9Q?=
 =?utf-8?B?U1lKZU85Zy9yUysxNVpOcUJoMVBvSWpiYTBOcjJHVG1BNE5tN2IxTDZoMUlp?=
 =?utf-8?B?Q29leXdBb0ZXbktLcHA2Tzg2VWg4SHFJb1p5ZGdiVHNGQVhhcHphWmtQQ0FC?=
 =?utf-8?B?c0JzeG9GWmdZRHpRWDRPZFNSRm5oNVk3WHNsQys4L25tMHJMRkJ6b0orcjBk?=
 =?utf-8?B?eWhuQ0V5c1JGNE9BN1J2UDkwL1l1VkRPVU16WEVmbzZrTFBkdE1ScjVQOXFZ?=
 =?utf-8?B?OFEyWFVxTEU5VlE2a0U2S05xdTdCWk5tb0g3ZmtuS3FnSVExdVNhSTI3WTlX?=
 =?utf-8?B?Z2tyOXpEUzRIYWoya2FCYjVlWFR3Q3puQUR6YTRFditBeW1hbVdvMmE4dmF6?=
 =?utf-8?B?N1ljcHNVMVhacHVuK2JsUG5nTHJ0V1A4eGZYUzZrM2dVRmVDMVpteS9pNHJX?=
 =?utf-8?B?ODdwVExIL3Q4ZkxnSTc5MS85QVRwOVRTaDFZZFhRZ1NUUGlxbnJiQ1pGdzVy?=
 =?utf-8?B?QlcxUUV1QkFpNjVicEFGQU5aRVVnemxhWjh4YlZFQ0pyVTBXOTl6SlAvNDFN?=
 =?utf-8?B?ZGJ1bGRxMUNvempaUldpaFBkZXFzci9STnQ3dUxQNVdTekxhZGdKQWxwQlE0?=
 =?utf-8?B?aDE4M01JWC9GK0RaSVZCRmlacm8rRmhENHZ4dmR1SzJVeDlod28yR3llajUz?=
 =?utf-8?B?QmpGSkhWZ2phUnNHYXhCazZFclQ0WHV5aHJWKzV6RDUyb3E0azRXN1JzVmEy?=
 =?utf-8?B?bEdnRURnUnlEaFIvU1VOR0NtQVYrMXY5RG5nYWZXbFF3ZnUxZ24wSWxEUFpG?=
 =?utf-8?B?T3pneFJlVEhrRm85T2F3dEIvc3R1VkFKTDExcEFidUlIMm12WmFkVFJHMEly?=
 =?utf-8?B?STltQWttMUVzY2NsK2J6cmxIZGJkUEpaQ0JUMEpGWXFsMFRyWU9nVWpZRy9r?=
 =?utf-8?B?YVR3NUZJSkczUTlBT2dpN1J6V3J6aDlpb3JDbUh6bGJleE04dVFhWldMS3NJ?=
 =?utf-8?B?RDVrRUlHTEdITUt1eEZUUjR4dHZrR0tPeTlpTDJEZHdnNWwyeHdMblZ1cGpC?=
 =?utf-8?B?ZmRRTlJPNjdOU1BYZlk4WWNla05vVlJ0eFVrbzJRUWF5WklTdkRXejFQc2x6?=
 =?utf-8?B?S2ZMenIzbG5SdmhHNHVmRWlQNHhLN2FzSnlQczJmTnV3UDhDMlpTMWRDN1B2?=
 =?utf-8?B?ZlA4NTVSd0RVN3k4MnZQUzVucC9wN3hoU2hPdGtUa2xhVUQ3OGs3eGlsNXVC?=
 =?utf-8?B?OUh6UzVwMjNIbHAwaTdMTFRrRkx5YU4veU4wV0dSc2dwdkJrSlArU3pjN1hD?=
 =?utf-8?B?S2xkYzhmMWpJR0hxNEU0SHJsK2hxdFphaHJNeU9FdHV0SXFvWWRMRk5jT0ZQ?=
 =?utf-8?B?VEp5OVJmYTZUeEpOakJ3dSttMnljRGpKTTdNUmdrMWNrNlNsaEtSS0tjTisy?=
 =?utf-8?B?Y28vWko3ZFk3YzZxSlBZM0ZDT2N6ZWtKMmp5YnFtbS9vV3BZYVVrNTdaWGda?=
 =?utf-8?B?aEk4WmJFcnJ4bUsyREt1cXIzQjRIckZJMUtqRERMN3VDZ2NIa2pTZkE0dU5m?=
 =?utf-8?B?UkFjdWJMeXhRRW5wb3hUb0FYQWFzTzdGczlWRmdoU2ltV09ITE1FWFlHOG1C?=
 =?utf-8?B?bXRnNnl5bHNleDJobDVrSmh2VnBpVW1QSy9RYktJWU0xb0RXdE5wLzA1enNL?=
 =?utf-8?B?RDRkb3UzcC9WT1QvdEpZM0ZOYnVOdzZZVHQ3OW45SlVxdVBEcWg3REVaRGxR?=
 =?utf-8?B?dnpHNUVoeE5sZVNxOGdTS3BzRmNWRlFSc29YeitTU2lYZEltdUxZQTR1VDE3?=
 =?utf-8?Q?PHk7DE2kI4yZR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3gyYWpsZFJ3L1EvckFTU0pDTjk0bzdrd2lZeUlyU0l6bmo1K1FveTR6WFVj?=
 =?utf-8?B?WHc1UXJoeWxRQUVHL3pOUUl3OGFYb1RKTmRRTFBkT2Z6WFJDVldCdmYwT1B6?=
 =?utf-8?B?OVZQT1EyQkFNUmsxTkZ6TWZZeDhKcXVmejkrbDAwbXg3VDZIQzJIUExTSUlr?=
 =?utf-8?B?c3NtazFnejNVSXZLMXFMSFZQUWlHbGFxczhtYjI0ek9aWHJ0Y2xIcXpzaE1h?=
 =?utf-8?B?d3llS2pQckY3dVB1YUk4R2Y0WnZGbmxCc0s0eVAyWjhJSzdOeS9QRHVQdWxN?=
 =?utf-8?B?QXh6aWpTUElOMkpKcjRkQkw3OTBBZVk1Yk5QbDFiNklTZWRBdUxPMmlzYWt5?=
 =?utf-8?B?VTZiU2dwbXM1aUhFUDlXNHRSSE1BT2tKR1ZhVmJTQ1B4L1Q3RVhYUjN3TGJn?=
 =?utf-8?B?YmFkUlZvNXd5Z1ZvQUpBMTZvUi83VVFYRmdXZEphSUpVMkdLano3SEI0VndQ?=
 =?utf-8?B?OUZ3ZlVOYVBPaW81cFJuUzJpRzdSOEpBemxkSk12Z1dMTFcyVVlQV0I0RlF6?=
 =?utf-8?B?VkNya3dlRmxxdFFIZjgybUFxaXhkdjJCaDJsQy9TREZXOXFub2F1WHYwY3gx?=
 =?utf-8?B?d1dVSHhUeFpWYWhrTEN4VGJya2M1OVplWWxlSDV2QTRldjh4UDVLQU56OGZ2?=
 =?utf-8?B?bXk4eEtEUTJ5clg3YnRCSE9aQ1hTbS90c04yaVFFUnlzelhBWENHVDk3Q1BV?=
 =?utf-8?B?eFpZQnpaaGFVNDlVRWd6S3huY25TZWY2WDg0V25ubVZNNXc3dFhIZzNyM0lp?=
 =?utf-8?B?R0MrTml6Y3dkOFpWaVoxTEtNa1hBUloxR1RPa3o0RjBkalo0dUtZSEVtNmZM?=
 =?utf-8?B?ajZBU0YvcVlhL2kxdVZvWUVIb0RYRm8xVXJ1VEJoc3dGNm1IRGNYMGtyeHdw?=
 =?utf-8?B?b3hoaGlNTUhOVDIyNlBObENKalV1amY5MXBvRHlPd0graDVsdk9ab0VpMFE0?=
 =?utf-8?B?eDQ5c0xiM1EvWFBidzFUMzM5TXo0RHdUNlkyNGFWQVhFNXRoR1VnZWUvUlN2?=
 =?utf-8?B?QVdRbVRwekRBQytmTVg0WFE4RmRqeExJY1gweEdpUlpualhDbVlEMjR5Vm1N?=
 =?utf-8?B?ajhESzZma25sV1Bwb2VKWlA2WVRIbG91YjVRQnhEMTJHaHIrTlV4cEZhd3lK?=
 =?utf-8?B?dHRCV0xvbjBsZlEySHBWZm1mS1Zua1dSUjJuUlBuY2JFekI0QUp3QVVZaU50?=
 =?utf-8?B?TGlTeFdjM0pST0NSdERiai9NcGlMMWlpTkIzSExTUTFaL0Z3NHV3cGV5U243?=
 =?utf-8?B?UXBvai93bDJ4NDJMTEVINjFtc2krOUNrQTNiSUpRMXBOSkVKbFpOcy9QWXFv?=
 =?utf-8?B?VkVLUGQxN1VneXlJVHJZYUo3b2NhK1ZGL0ZwbFYrTkhkK1FZQUFrYmw0clFp?=
 =?utf-8?B?MXY2MnhDMStSemZOMlVmVE11ODB3UE14VnFMTEdkWUlaRUZoUWM1ZWRqV1Ry?=
 =?utf-8?B?bjlaQVNXQzFHeFhrclgzRlpiOW91THJCY05sZE5ZckVVSFVRWVVVQ2o1NmFi?=
 =?utf-8?B?dmRoLzlFWG81eWJmeG4yOWpQTFoxT2FPdzIyVElGQ3lYdTN3WmVKbEVBa1dN?=
 =?utf-8?B?Uzg2SXB3Z3R6VXcxMEFpMjVWNFhtUDJ1Y0FST3BvY0pyK0NUL1JjWVR1OUUy?=
 =?utf-8?B?aWJDZElGYWM2amJNNzAyS0JaSDhwNVhxZzQxc3lZdEdPUTlTR3RXcjhSSlNh?=
 =?utf-8?B?ZXAzTnVrUStqNDkvTDhwSGw3cXFCSWZtRG9QMlM1OTkzTU92MTRuZ2t3QXI3?=
 =?utf-8?B?cDQyOW1GLzlNUVlsZC9oMXliTnB5Y0Fxb3BLRzZuK3RxYjhZTXByL1ZJbEs3?=
 =?utf-8?B?cEJIWXNkWnZCZGFNdEh4N1ozNXVYYlVaVnlUVUZiQW1LQmFYWm8yVmFDN2VT?=
 =?utf-8?B?M0xINHdCV05VTVBRUFczcUVhOUdBWDNWRFRVcWZOZEphMzQyeE1nb0IybUZW?=
 =?utf-8?B?NDFOTXAwK3grR1lvZUNLZnpHUGs2V3lCc1JzYllZYU9NZWJab3RMckxkRDFO?=
 =?utf-8?B?aHpYWFNuYmk1aDZxeGtialZ5M1YrSzRzeng2QUZOaHp2blh4NVlzbmxUbk9o?=
 =?utf-8?B?VGI3S0Rta2FlWSthUnNSN0tqUE9LRGgrQ09pdXczRVhhcS8wa2dMcFZ1RGph?=
 =?utf-8?Q?BDuubBv7ye8Sg0QOTwe2H0UEo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1759cf65-ee29-47b9-0ba1-08dd2b677f72
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 19:56:07.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0ocKvNkAhTKPRHyrpkHV6i3ISYH3dUQfZZktHoRg/BV2bbwM2waFWdNhQpAwFOJLDKb/WK6FndfBsrIL0aFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526

On 12/24/2024 10:14 AM, Jonathan Cameron wrote:
> On Tue, 17 Dec 2024 02:20:32 +0000
> Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com> wrote:
> 
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records. Introduce support for handling and logging CXL Protocol
>> errors.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error trace native CXL AER endpoint errors, while
>> cxl_cper_trace_corr_prot_err and cxl_cper_trace_uncorr_prot_err
>> trace native CXL AER port errors. Reuse both sets to trace FW-First
>> protocol errors.
>>
>> Since the CXL code is required to be called from process context and
>> GHES is in interrupt context, use workqueues for processing.
>>
>> Similar to CXL CPER event handling, use kfifo to handle errors as it
>> simplifies queue processing by providing lock free fifo operations.
>>
>> Add the ability for the CXL sub-system to register a workqueue to
>> process CXL CPER protocol errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> Hi Smita,
> 
> A few really minor thing inline. Main one is this needs a rebase
> as the EXPORT_SYMBOL_NS_GPL() macros changed just after rc1
> to require quoted strings.

Okay. I will rebase and remove blank line.

Thanks
Smita

> 
>>   #define CXL_CPER_FIFO_DEPTH 32
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 740ac5d8809f..5bad24965e24 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -650,6 +650,68 @@ void read_cdat_data(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
>> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_uncorr_prot_err, CXL);
> Needs a rebase on rc2 or later.  "CXL" - quotes now needed.
> 
> 
> 
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 188412d45e0d..f6d467cd9232 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1067,6 +1067,51 @@ static void cxl_cper_work_fn(struct work_struct *work)
>>   }
>>   static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>>   
>> +static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>> +{
>> +	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>> +				       data->prot_err.agent_addr.function);
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>> +					    data->prot_err.agent_addr.bus,
>> +					    devfn);
>> +	int port_type;
>> +
>> +	if (!pdev)
>> +		return;
>> +
>> +	guard(device)(&pdev->dev);
>> +	if (pdev->driver != &cxl_pci_driver)
>> +		return;
>> +
>> +	port_type = pci_pcie_type(pdev);
>> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    port_type == PCI_EXP_TYPE_UPSTREAM) {
>> +		if (data->severity == AER_CORRECTABLE)
>> +			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
>> +		else
>> +			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
>> +
>> +		return;
>> +	}
>> +
>> +	if (data->severity == AER_CORRECTABLE)
>> +		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
>> +	else
>> +		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
>> +
> No need for this blank line.
> 
>> +}


