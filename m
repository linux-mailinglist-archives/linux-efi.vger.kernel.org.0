Return-Path: <linux-efi+bounces-3467-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA52A9D060
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE554A6B3A
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E0C201017;
	Fri, 25 Apr 2025 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rEoKmu+Y"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB7214A60;
	Fri, 25 Apr 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605146; cv=fail; b=HJX3P1pEMYFY7NDU5boATU88Vp13p38UUKlAA5ePS1RwUYeyrlpjxyLgzjVQNBiOFaevkgvNUmqyYnibgcf9z/Tf1zGrfDxEOUrIG/NPcCM2F7L75PPFSy6STQlbfuCs/s2XgqzWca+552WGBDdKPU4dfmoKR3lGZ6TbaXowseU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605146; c=relaxed/simple;
	bh=ehXJW+2tQ+HMQ14DqUJlgAIgNNmsB2FFQcM2vua4BQU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1Fq78XRWPjowATYIapbrdq9MqIC6OgIjiB9lBzit1x5C0RuMyN/Tt6kgQvXnH+i0bX4ES1lK/Ox2x8wj3fJo8iXQgdqK0ms0t7sfbLT4efST4j7L+GgH+2za7+Cu1T17o+iIbp3HCIXsVaFyWJiTXkaqNV4V/BNV/YR7nlEssk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rEoKmu+Y; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6dipNSw1E2Iiw1LpfR5oH2UBsiRXRe1B1h7Z2EGZ2E/0zZeYneuUCYp3jmoNhvpkd2CIYJ2gg7j43rpXTzlEY33rabYtS1s3eaobX7/YSAdGH7KRMhQpYVHAtj71jyPTpWJVhoHe6BVsFqyyAtI2BKe1SAiLbXiDynosrLeHwgdQNKXY3XkeV/7y8jO9XP1et9IV1ac9gbAEQN2b0IIqk42egUSCX+sMjf5rg7RFs2CVVcQiQEe4JWi01I86fNVQTiM67ld8I94FrI6xpYaixVCTQOvw62DkYsKDwbpb7awbgfHTiDvcGIepG3z4vhlIJW/KWfLGkvlYUtvyZXd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G9lVpytpyWXOS2ydICkHYv6oEEoTRaL44TmNsCiLpQ=;
 b=LrwtI89Vq3BhuEh1uKnRQMrS/am+sxb8jja1Pzh59esmIX3bp8dFTKbEU/FDMiUrJNdGpJ3CWCV2inF6V27hbx1mHxURfC9LttrzKYQFvY7w9+jtlZsHzPBWLlWTTXTfdtA5CDsNwUrTMalySEm7fo2P/vTipWRZ2MXJFi8ymvSJIbpdqnnnjyaMS9TlPXfN8ohz0OeoEVj79F5qOEFsCs1kSg6WcK940qNMiIeWTGi4KyAZEhu4OTdRO+AHWP9dydDKgFO0Jvqp3NVWQ5efZ8onBOF/WpCnVVgmoiVJ9XdF9VczcMqU1ruxeDQc6rG4rdRff1Banhhf9/QeVxKplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G9lVpytpyWXOS2ydICkHYv6oEEoTRaL44TmNsCiLpQ=;
 b=rEoKmu+YcJfmJ87C8f/f/ZBfn59eXZWWl8Ei5rpYkB4+ixxn0lO0YCjk0/b1ZdI6HT8IIerabmAemqYrwwQS0OkQtt+5GStRooVFoGfkz00jwbHKV2BUCXKO0/1BN4WNTHKL3nx8OBPoK3/QfO4rULgEi5f1HHRDdSg9VTecRO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 18:19:02 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 18:19:02 +0000
Message-ID: <4ea54b5a-1a2a-8677-0bab-95a61f243a6d@amd.com>
Date: Fri, 25 Apr 2025 13:18:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250422100728.208479-7-ardb+git@google.com>
 <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
 <CAGnOC3b2XBFw+xdMhTtpfDYG480BG-KwfkPMWOiOP+13XeHFfg@mail.gmail.com>
 <CAMj1kXFCqLnWDw7hJVL9FShF9V=YZ_Ucf6jSSeq0E=BeuENdkQ@mail.gmail.com>
 <2294bbdf-7860-f6c8-0162-992ee79f4817@amd.com>
Content-Language: en-US
In-Reply-To: <2294bbdf-7860-f6c8-0162-992ee79f4817@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be0c3e5-66eb-4681-5937-08dd8425a808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzArdW8xa2lNSTEwTEowamprdkJoZG1CRmdvNW5DRE4yZU9taVhkWkIrbkpF?=
 =?utf-8?B?VGp6K1h5NTVlV2JZVWQyVHQ1Q3pUMm1wZDlEVU05c1NGbm5QS1orQ1hHWUM5?=
 =?utf-8?B?WVJYa240UVk3ZnowY1BoQ2RYREJFZC94aERRa2FtbkNpM0ZwYm5UVENpUjBj?=
 =?utf-8?B?T2N3NHpvbG8ycDVvK1pSUmJqZklTdlZJNnBxSmJWRzJudExQUXpqQWpUajBX?=
 =?utf-8?B?S0tCSDZFaE13OEt1VlYvRDU1aVQ5TUVBUEZmUzV3aVBUcVZaQkwwbVY0cEFC?=
 =?utf-8?B?T2lvRVpMVWZNZDduaTF4QlZaaWQzbVNYMkhWblYrRFo0bnIyOEFQeUdOMFNn?=
 =?utf-8?B?cC9oWDVyQkJmL2ozcVhtR1ppRjlpcUp4MmpQc0tXNDhFM3BjdjZXYWZ1UGRi?=
 =?utf-8?B?Q2Fyc2lpWEFMcXNaN253QU5kWGQ3Z2JUbWNsejAzSEhpVzBha3ZCbWVsbm15?=
 =?utf-8?B?KzhwckFQUE1RN29kaW4yYjV4cTFBYU52OUtHTWdRdnAzbTVUVmRQSzhUWnlu?=
 =?utf-8?B?T0JyUkUvZHRTSXN3WEdhQ01TUmNPUmVXWWhjb1FZazZlUTdqQU9vOG1VRDBF?=
 =?utf-8?B?N2ZVK1lZeHl5ZXppemY0eDlhUURTVzB4dFJCU3JRbjhrWUd1MTlPZ1pMMkxY?=
 =?utf-8?B?ZndOU29KbGk3Y09aMXBKaWI2TVpjcnRXZlBjZHZFbVYwNkRQM3JpL3IwUGQz?=
 =?utf-8?B?WmVIYWU2Yk5DSExlYkJ4VWNjczlSb0dpUU5qempKT2FzTmoyWFI1d0tSQ01Q?=
 =?utf-8?B?Q09wNmdia0VrZmh6bkoxS1BXYVBRQmJMb1JENnpvTUwxVnRyckpWdjdDcW5I?=
 =?utf-8?B?TUdjdi9pSkI4aGV4THJhdzhOVG5MRmtTeUhFTC9YZDRoNW9kU25sYTFCbHhn?=
 =?utf-8?B?aXVyMllVWVFBQ0xGdlhUeXd6bDJWZDVaRTFhMHNmdEN1c1VCcUk5ZVBIaWpo?=
 =?utf-8?B?aHNYdWlPZUlpZU1lQS9qTGJGNVRkdHB1TmF1RFkvcUY4VXZsVjhwci9oT3h6?=
 =?utf-8?B?aUg1UmVXYzVsRnZ4OG9xZkJWa2lKN3lTMHdRKzg2a2tUMXRBT2dnSTZEaUdZ?=
 =?utf-8?B?WGFOYUs0NE9qdnVDVVJnWWJBZW94LzZOYktUazBaM3pQdERNQm1UOE1iRjhO?=
 =?utf-8?B?dnNlUzRRUnduc3FjZVZZdkFySFRqNHpkVkxkYy9ycHZuTThrTmVZZi9ZcXJs?=
 =?utf-8?B?S2hGdXFQSVJuL09heEY3YmFXOCs4aE9IbXRsNUp3cCt1dHVsdU8xaEh1RmU3?=
 =?utf-8?B?TFdqMCt3YUZXNDRRVW0venlzU0ZZcHFaakxoUHd3MjkrcTlGR1RyWDhIZHdH?=
 =?utf-8?B?YlYrK3ZidlN4QWQ4YVhDbkg4bWo2ZjVYK0pIUDU1OUFpRXVvNWRFakRlN2Jx?=
 =?utf-8?B?Vi9URDE3TzcxSEREOVlkMkpmdlB3YjB4bmxLaUtYQ0lCS0pYVGFXRkF3RUpR?=
 =?utf-8?B?TFk2K3J4OU9WUW9EL2t5Y3dNSGZVZkZNUnVYOGhJcXg2bi8rM0N1MEVoN0Yy?=
 =?utf-8?B?NTJsRXdDV0c3dmhobTViVHFOdlo3WExsY2hZakIrNkNrRk5KS2NxUzYzNnFF?=
 =?utf-8?B?V05xNWdKbnJLaldxTjVicXJiZGttSE13NlIyYjRCV1k4bVdwcFNhM1FuUEZS?=
 =?utf-8?B?MW95ak90NGtkUngrTVJ0Uk5GZEJSQ1NRRTNJejY3cjYrelc3amdmbHpUN2hH?=
 =?utf-8?B?NlcvanplSG9zU1RYUTliU3U0RWVmR3Vsd1ErTDdOdVhZNyt3aCtpNUtqVUM1?=
 =?utf-8?B?d1doemNTdEl4ZUM0RFc0RUxKN1ppR0t4NjRwS0F1UytPcWZXcjV2Umw4S1hZ?=
 =?utf-8?B?aDA2bkt3YWp1NDdkWVZzSWtzT25JMFV4NllOSEk2SmUxNWRJNnJGc3U4OFIv?=
 =?utf-8?B?MXJaNE9RTDUwSS9OK0I5ZDZHaklOaUI4NVNvM2d1RVpISm4vWXFxQy9qaFZM?=
 =?utf-8?Q?68vCmv/P51c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXMvL0RDdkI5WVFtNk56YzRjVmdENjM5dTVxSmgvbkxnUUc0cjhpWFlBU1JO?=
 =?utf-8?B?OXMxbjM1aU9Ob3BzWEVaaDd3UUNaVjEvU0dTMGpKL1Y4N29HNVQxNnlTTkNE?=
 =?utf-8?B?S0tlQ2hCMFJybWM2dGdtRFhkeDI0NDQ1OG53cklZQ2xUOTN0eTdEVEJTUU1H?=
 =?utf-8?B?dnl6amlTWDZWb3d5MDdRTVVJN040SkZSdStERkJPbVBKQyt6azk2Y3RHWVla?=
 =?utf-8?B?Uzc3c2FzTWZHWlhYci9aN2dpbWFGK1FqNWpOM0NhZmpDYWRNNndOem1YQVBy?=
 =?utf-8?B?Wms5YTVLRXhjMnJuUVU5Tnp3aGVRNmFETS9Fb0hlUnhmcEYrQ3dVL3pCektP?=
 =?utf-8?B?V29va3RjZEdqREVBa2VRb0ZCbGliaHVLb0hqNG5ERk1VVUUwUXFOdUozd3Fv?=
 =?utf-8?B?TWtsSGU4aWhKVHVqQ21HY0dseDlVaGNjQ3dOMjhvaUVXQk15Y0lUSUhGdnFz?=
 =?utf-8?B?N00rT0FUSHBYOWdNaTZYZWJpRVZ4TmtKNDZOZnJNeHVvYzQ4LzJFSjRkNWJl?=
 =?utf-8?B?eEpYYTBZaTlRZkZOMGZoS0MwNU1FUy9DZFMrTzExdTIzMndsUllxMlViWmtr?=
 =?utf-8?B?MlZ2Z1FDNWh6d1JGOStjUzY4Z2RGZnozaXkwYVhobkE0QTY5V29Gc0E1TllW?=
 =?utf-8?B?T3JpeTNIVFVXSzVVUjVNTGtDTmxJT1F3UlJjRC9LZEhHZ0QyV00ya08vUmQ2?=
 =?utf-8?B?VHVmNERlblFZczFhQ29ydUZmZmc2ZlJUWVNzU3hYZkNDYThFVDRFQWVPQ0hG?=
 =?utf-8?B?ZUtwcWV4ZHpRYmw2K1pFWCs0TXZTbDZwWkJ0YUR4U2xHeXUxOCtuenlkVHNH?=
 =?utf-8?B?NThYWVkyOC96MDZDcUNHelhWOVNIMGlzZDV4MVAwM0VTVjRnZHIyeTcwbDdn?=
 =?utf-8?B?cnZGUmdjaUtyMVRpZVEvcFpqNkNqemJQdktDTk1BSU1iaUlIOCtpOFBaV0JO?=
 =?utf-8?B?N1dSSjNHU0hOV0x0VllzQmtaWHVOQ09ocG5KU3dwZmJvUk1JalBiWUhPVDhP?=
 =?utf-8?B?YXFQQm10RVM5elZBQUVmL0huaDNDYjltQmh3akt6OGxBNWFleTkrenFJMHBR?=
 =?utf-8?B?bWVOUEZQNitFTEdHaGlYczZQckN3aEY5RUVDb3BMMzh5UFZvTTNSb0NqaTg4?=
 =?utf-8?B?MEpLUytpOXNaZlBHeWdHejdpKzhQby83Qmk5T1pwRHhLR3JYYmorZFRaMVRG?=
 =?utf-8?B?QUlndHdQelFXOWthZXpOMlBHdWpEMUpONndqQWtLWU1Sb0UySWI0THFEQSsw?=
 =?utf-8?B?WnIwcCtRZWgrM3ZKL0FIbVp5V1g3OStoYjFGYU9JUWVDUUpWN1E0QURUbm8w?=
 =?utf-8?B?VVJENW5DZnFaeW1nM1hFRG9YNDRpN3lreTgwMlNHdDVRZkI0cXZIdFh6RmVE?=
 =?utf-8?B?c0xYT2FQNXlQZ2ZSU0FWM3FCbkhYMnJEMjlnWlNmSm90SUxKMmFsSnFuTGJo?=
 =?utf-8?B?VDBMamY3dDM0dmx0N3NLbUhpSkp1YmIvaG0ySVhsekJZc0NOU29aYllNN3RI?=
 =?utf-8?B?TU5tRHJqdFNBc3UrT1ZycXBGUCtJSzNrYjJ1S01jbkNod2JJV1Nrbnc2ODN0?=
 =?utf-8?B?RVRmbzZUYlc5R0NUWEhvemUxZlZmWlVJaHJqTCt0ZGtUSEpuS2FtL3F4QzYr?=
 =?utf-8?B?YW1kN0JFUnJjNXZ4M3RlcXFKZnJCM2NqNWtlUFVuNTRXMWZCN2RaaGdXckxu?=
 =?utf-8?B?WnA5b0puNkFYNkhFcE95eTNTKzQvaCszT21pdTVOMzcrYSszV0pLM0cxc3Fz?=
 =?utf-8?B?bnpQL3pYc1k4amZiVlFMYVpNdG5CWjhaT3JRVXZIYkdHRVJNMEZMTDZXZzNm?=
 =?utf-8?B?RlpYenZCblhXTWQyUGF1NXNERzJ0cXZIMDdZWG1NYzhsckZaQ2FhQTFmYndS?=
 =?utf-8?B?MVdSTDRuUjN2L3E2bDNNSWZEUC9TRlJwS3F4TTJZQ1pSWFNSVytsN05iVUpO?=
 =?utf-8?B?M1o5dFc4eXFVTjBqWWR1WjRxRU1EdnpzbGZDUHMwcjMrVG5wODZuUzZaU0Zw?=
 =?utf-8?B?MEdRMVVkQWN2dlg3ZFk3cXB4WmVXdmt0TlM4MDJTbDBqTEsxUUo4bVJFQXZq?=
 =?utf-8?B?RmYrVXFibHpadnlUbmJPUDlUeERwRTR0TXV1WVVqODFpNHJwWVlJNmxoUEtZ?=
 =?utf-8?Q?PSu7MYbEstxlQVRe6kUmr4LmL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be0c3e5-66eb-4681-5937-08dd8425a808
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:19:02.6479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdML8LmRS6vtUwwvzuJea4Q1PznybVEv9umxjG5idYbsP4CN1bh4AzMDhj11J8XxfC7DsyY7RgdEfSSC3A9fGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

On 4/24/25 09:18, Tom Lendacky wrote:
> On 4/24/25 02:22, Ard Biesheuvel wrote:
>> On Tue, 22 Apr 2025 at 18:40, Ard Biesheuvel <ardb@google.com> wrote:
>>>
>>> On Tue, Apr 22, 2025 at 5:51 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 4/22/25 05:07, Ard Biesheuvel wrote:
>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>
>>>>
>>>> Hi Ard,
>>>>
>>>> I'll try to get to reviewing and testing this series very soon.
>>>
>>> Thanks.
>>>
>>>> But one
>>>> thing I can see is that we never set the snp_vmpl level anymore in the
>>>> EFI stub and so PVALIDATE will fail when running under an SVSM.
>>>>
>>>> But I don't think this series is completely at fault. This goes back to
>>>> fixing memory acceptance before sev_enable() was called and I missed the
>>>> SVSM situation. So I don't think we can completely remove all SNP
>>>> initialization and might have to do svsm_setup_ca() which has a pre-req
>>>> on setup_cpuid_table()...  sigh.
>>>>
>>
>> Why is that, though? The EFI stub never replaces the #VC and #PF
>> handlers, and so cpuid instructions will be handled as before, right?
>> And the SVSM setup code will run again when the core kernel boots and
>> this time, it will need to update the cpuid tables to record the SVSM
>> presence.
> 
> It's more of a statement about the CPUID table modifications made by
> svsm_setup_ca() that need to be skipped if setup_cpuid_table() isn't
> called, not the use of CPUID itself.
> 
> But taking a closer look, snp_cpuid_get_table() is actually returning
> the address of cpuid_table_copy, which is a static in the file. So maybe
> it isn't an issue because the loop at the end of svsm_setup_ca() will
> not crash, which was the main concern.
> 
> I think we can use CPUID 0x8000001f_EAX[28] to detect an SVSM and read
> MSR 0xc001f000 to get the CAA. OVMF has that support, just would need to
> figure out where to check for it, then we can probably skip the
> svsm_setup_ca() and do everything in the snp_accept_memory() path.
> 
> Let me take a look...

Initial look at something like this works (along with the fix for the
mistake I made in OVMF). I need to test the kexec path to be certain,
though.

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 478c65149cf0..d2f9cbbe943b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -142,6 +142,7 @@ u64 svsm_get_caa_pa(void)
 int svsm_perform_call_protocol(struct svsm_call *call);
 
 u8 snp_vmpl;
+bool snp_vmpl_checked;
 
 /* Include code for early handlers */
 #include "../../boot/startup/sev-shared.c"
@@ -241,6 +242,29 @@ static bool early_setup_ghcb(void)
 
 void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
+	if (!snp_vmpl_checked) {
+		unsigned int eax, ebx, ecx, edx;
+
+		/*
+		 * CPUID Fn8000_001F_EAX[28] - SVSM support
+		 */
+		eax = 0x8000001f;
+		ecx = 0;
+		native_cpuid(&eax, &ebx, &ecx, &edx);
+		if (eax & BIT(28)) {
+			struct msr m;
+
+			/* Obtain the address of the calling area to use */
+			boot_rdmsr(MSR_SVSM_CAA, &m);
+			boot_svsm_caa = (void *)m.q;
+			boot_svsm_caa_pa = m.q;
+
+			snp_vmpl = 2;
+		}
+
+		snp_vmpl_checked = true;
+	}
+
 	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
 		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
 }
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
index 173f3d1f777a..5cca01700280 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -1342,6 +1342,8 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
 
 	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
 
+	snp_vmpl_checked = true;
+
 	/*
 	 * Check if running at VMPL0.
 	 *
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 5b145446e991..5011b3a93a21 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -99,6 +99,7 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
  */
 u8 snp_vmpl __ro_after_init;
 EXPORT_SYMBOL_GPL(snp_vmpl);
+bool snp_vmpl_checked __ro_after_init;
 
 static u64 __init get_snp_jump_table_addr(void)
 {

> 
> Thanks,
> Tom

