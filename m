Return-Path: <linux-efi+bounces-4548-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF0B25530
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68981C8441D
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A030AABD;
	Wed, 13 Aug 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="G3WFTmAA"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2110.outbound.protection.outlook.com [40.107.237.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDC309DB7;
	Wed, 13 Aug 2025 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119990; cv=fail; b=fnEIkOPdZvJEVr4aCWqKY1VX5eQr1Vkap32E6zRV7IEIM/pYWaYQO9voboCaQlX0DqPQ34aY/N20XitsS/VVURAuO3DoYDGIp7S7N1KvJLTKNNjebbx4QaYpsCfo64Yu6JffyTmj+fH5ayc3HOmYypu26+yJ40UBKpcqumUMDgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119990; c=relaxed/simple;
	bh=W9uCxRmXFi4I4ZipftyIxfEBg9sBVDNykOu0JSV8rGE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FHkxOPbnVk+48cd4mefjpBH8Z3j7ZVtsEFOn6Xs+ZGoadrh7CtASOy2XKLwOZBM5jQeh+IUt9UvZX2kysKMqkbibAeCCvfIUXL+B0o0O3hQFAGFUiS0Hr3MB2pzooa0dMm4E8WG2WCO2AR1Ap31vUJl45kOzrvD/rK0v0BIMWvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=G3WFTmAA; arc=fail smtp.client-ip=40.107.237.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys4Ln1blP6lcJDdgnvF9cziZSza4+IS1a9VbMb1Xz7pls3pvN5Z3CccNDdEMg68m47FAKGVSLf60ZOu7iFVaNOGNZbnDlEh1rWozMVukl386rZV5UgZ8CcYfGCCIbuCmX7B8C5VhO1aZqxu6fwt0hp2hciHBf4lCTYEIveBWtCR2wtwhuKj8wbRYztmzmNJNpWbyFymBiKFvC3I3h3e/mdXzgWKpuqbm2I5GfMihY21zXAzSMmYTuN4eel+moZpVjM4CDjR7TzWP5xpt4bc8Q2e5Yml2asKF63BCbXI4bGrdeNECTBRSRlNJjtcwIsiHVjT1GaXN0eZECouOsJuK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDPdh5/KZZhUE9C8eI1j3GemRKaQ4CISdV05oe41s8o=;
 b=qjiKJuPBD/LJB6xbAzoy0WpCswlPb5xADZ6dNK8itRnJgH3KUC0HCVDUB/bQ00x0zBmywN7oFg2f00JMe5uA0UxFLNoHI+T0RkAXGsBIlz7RheK74yIj/qbWntFaUecUo6nBhZZKZrX+yhVsuSPYhs+u0XFYPLtTJdNroIZkH1kgJJ2MUsyA5Q4a8wBhzF0nUlGwaxCSNtfBGNZeaqJLfg9P3XqiJswiP1dEwmz9VqACqX0l4zeb388QUbZV8klmFpXRNx6dBedqDvzEVAMzilnfcQI8Kft/LzSd5P4BlLXa+7nGE+bqtAa3/hoDSpOUVSe2hG9r7QzljmnjvI3YHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDPdh5/KZZhUE9C8eI1j3GemRKaQ4CISdV05oe41s8o=;
 b=G3WFTmAAX/aiXkDVRKHqHd+kM773p/bByR47ymbzU9UO4M7NKySAqk30+swxwMHMGozcBFdxY4A7T8bD6dPhXrBVznoamu+XB/Vi5QDZTrCBxzMSvnKjyXK7ZIVhkci8FNDC9JXG+LETt8bQs7fOmYMdA+fY0jQ7MdqUPb/pWcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 DS2PR01MB9390.prod.exchangelabs.com (2603:10b6:8:270::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 21:19:46 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:19:45 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Wed, 13 Aug 2025 14:19:17 -0700
Subject: [PATCH v5 4/5] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mauro_v3-v6-16-rev2-v5-4-954db8ccfbe6@os.amperecomputing.com>
References: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
In-Reply-To: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CY5P221CA0096.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:9::31) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|DS2PR01MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: c17c938c-972e-4bfd-05da-08dddaaf2086
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTU5N2E5WTh3WHVIV2lTUllRc2hPTDBzZWF1cWpDWUdudGJpdFJkdHllNDdX?=
 =?utf-8?B?azl4MWxOc01kQlozZC9ybjlSYXFTblNYMUNWVitLNkVtbS9MSVRvWGorMm1x?=
 =?utf-8?B?akg5ejQrT3Bnc2ZnaGxCd1p4cWRwR1NDSXhxdGZMcjlQdkVkaUU3WHQ5aHpu?=
 =?utf-8?B?QkRaRFNwamtIUlUxSWhENnE2L2UwdWFzaHJRT21mMVlaUCtHeUYwS25nT1BE?=
 =?utf-8?B?L2FRRmRSTkh0ZFRJUEVndTdiOGE5SkZ1N2ZzN3F1NVRkUDhmOUY3Y0Vub0E1?=
 =?utf-8?B?MDFpVDJEVmlxZGd5OUYxUzY1cmptVjYxamkrVGtRQXozOEI5V1NCSjliRW83?=
 =?utf-8?B?aFFqRE1aQnNwRUVFUFNWNGZBdG9sZVBJRnRaUDRaWldFQ1BvQlhvUzZkb3Jm?=
 =?utf-8?B?SjNxSURMSmMxZklNWjJyU3VqTXlqQmd4d3g5bkE4QlFwWDk1M3FSUHVJRUQ3?=
 =?utf-8?B?Mlp1M0F6bmNocitGVGNZTVM1UlJLMXF2c1hQaHloRFhmNmZDSE5nZEdwekgx?=
 =?utf-8?B?ZlBWQUY5QjNRTTl4QkF4YTJrbW1zOEk3Szd4bmU2aEpiOWI2MnBubngzcG9F?=
 =?utf-8?B?N3dTUHRxVnh6YUdUSXNPbWYweDdsWDVubnNTeVRIbTNiQ1o4ZnRmanJUaThx?=
 =?utf-8?B?Ti91NVRXYkVoOUdnOG54M1pJaFhKY0NwM0Z4L0IwQTVYd0hKM1pKemJvRU9E?=
 =?utf-8?B?M3hLdXFJMXdZcW5KWTNBMUJHcElnaTVkZTBiVlNlMzNIU0QyUDRYRFhKWVRN?=
 =?utf-8?B?azJ5cHRuUDJId05xZCtTL3FNMytkSFUreGpwYlJnQjA0K3RZR0c4azF1T1Bn?=
 =?utf-8?B?NVd4aGVRNUJaS3EwUlNrSlFGcDlMdWRFQ2NLYkRHandMMjR0UFVLWVVoUnp4?=
 =?utf-8?B?VU12OE4yTGJBc1JDL2IxbE5OeUlmQVhsc0hEaHNzbGM4MXRPMDZHS1AzZlJW?=
 =?utf-8?B?eHlvNVpUaWZqRVpIVEY2K2l3eThrQmFnejNZbjhiSGFwdWxDN2dJYnJrbWkr?=
 =?utf-8?B?aWpYRWdxbUFRbU5HeG5qaG94L2FsdVpRa2Y4WXFGZTBaZmQ5SUlCUk80MXQz?=
 =?utf-8?B?S0pUVFJleXVNQ0FDREREbGlCMVBRN0dWSFpwVm5NeHkwSWloVkdKZVZKUUdG?=
 =?utf-8?B?V3krUms0V2tIdWRucnpuMDNjWW1CUjl6V24xL3VVR0VEd1hIUkFGUVRNMVVn?=
 =?utf-8?B?ZVVHMFZRMUR0YnVRNmpOeTJMcklVTW85Um9QbG9HOHJROWk4eExtSDdQcldE?=
 =?utf-8?B?WVR4ZWxXNVNZQWtFZmpLWmJXVEE4Z3pyUEFWUlIwQnAvUFE2cEhiWExRZloz?=
 =?utf-8?B?Mnd5a2FMZnVBTHdVb09Fb0tpUXNJc05HcmZVTWdzVWxpVit2NDNXMUZhS3Ex?=
 =?utf-8?B?QnB3eDkrUjg0eHRSZEthNTdaZW5iZ1l5YWZ3a0lnNWpyVU16YVNBZmFHYlJK?=
 =?utf-8?B?bEpSYk5pZGs5cThnL0diZlNsUjlMSS9jR3QvQlNpM2Qvek10TXloUGRQMnFo?=
 =?utf-8?B?ZkNxbjJwMmplZFpxRGxEeHlURUwvOEhKelBrd2I3TkJDbkJKbk5OazFqa0J3?=
 =?utf-8?B?Rk9aNXk2QitNanVwUGZwclF5dThUOTlJSGw5QTJwclN4UnR0Wi82NU5pbVBZ?=
 =?utf-8?B?QmswRjF2emh6T05NVmhxcDRBNWozYlhzQVdGZGJ2RTFKTUpPVEpCclZqdG9r?=
 =?utf-8?B?bWZnUEp4eFppbVdaYkJkRUFBcTFtbWRPNit5Q1Q2cXo0bUwvUXgrNDlHOUVq?=
 =?utf-8?B?SGFGRThhaU5ZUnRiRHRSMEIrVUhpV1lvSmpvajc4S2JabnZvak9qeHpBUVRY?=
 =?utf-8?B?cHVjM2hpWlh5ejF2QmoxdTlJOGVLbDFYUmdOaW5jdk9wbExVZnVTZUcwRW8w?=
 =?utf-8?B?ZXl3bWM4a1JMYVJyaUFiTVQxSmV5elZ4UE9DTGY1eUl4WDBIdjBza0IvVmlJ?=
 =?utf-8?Q?0rVy+bacDiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3UyUmwySXNFTWcvTy9ldXdYVnZzVWRPUHdYK3poa0xVQWFXZG5jTEJCay91?=
 =?utf-8?B?ZUZ2M3dvSGlBSXppZXl3T2pieW4wR0hNMFN3bmdBSnpKYWwvM2wrVnJKNVFj?=
 =?utf-8?B?enNodkttbGlnNHNocXhlSi9XRENHcXdLNkEwQWpUbWFPTisxbytZOHU5RDNx?=
 =?utf-8?B?TkhQaWFJZnVvZUJTWnVIYUZId1ZZa2tjMjlKOUwvRm44RFpJa09BS0hieTNw?=
 =?utf-8?B?U2hNV3Y1OXk1aHczQTh4UnRKVG1sSXVpeFFUL2JLM0t1UkR5U3RhVHltQmJn?=
 =?utf-8?B?OElpK1hYdVRxc2Z4MUxKYUltNGs4NmZIMEROVWxLYWIxUXgrekhEN3h6WkYx?=
 =?utf-8?B?NjJQM3Q1OUlWbEtqODdUYWlYQTdKWGdHU2w3SDlIRUtvNGVrTStsTlhpWnR3?=
 =?utf-8?B?SnFNRnFYRUgwVDJhZC8wYkdqVWNTbldFYWVYeXllSDBZaTJLNEorR1hkejFB?=
 =?utf-8?B?QTF2ellPUlhVYUFvb2FjMitQdzlvNnFTYUQ0ZHZ0Rko5VWR6R1dvVEJKUUF3?=
 =?utf-8?B?TXRsMGh4L05rYm12ZTNrallnT1AwbXZKL0dZckZDWEFTeUttNXM5Mm9WbXBX?=
 =?utf-8?B?cFVWL3RRNHprU2t6bjEvYkhFUzRRZlhGTXdIOWlnQmlxZWYvT3M3QWNzci9C?=
 =?utf-8?B?Z1U2MUNCNGJGalk1QVJLcU5ubU5ndndGdE5sMHZONWxkbkdJMEdFa2VZY0RW?=
 =?utf-8?B?b3hPWEJqYmFuN3Q2KzgvSFBwQzExVGpXRjczR3gwS09ScTZSUHVlQ3lRRUNY?=
 =?utf-8?B?WUFvdmV3dHd2OHYvSXM3Rmcwa3RKOW01QjRUL1N4alViMERMK1piZDlYUFVz?=
 =?utf-8?B?Ung4RWxXV2ZuSmJPaDNlUVgrMlRTeG41a2E4OUxoZm9LVExKanlDZW1XMVNH?=
 =?utf-8?B?RGt2Z3E1OXBmY29rRFdzSlBHbTU5V29vdFlaR0VsbDdpUW9KOVdYWGV6WU83?=
 =?utf-8?B?cDdsdzFUQ0dCMWFvUnR3UjZQcnNpcGtrWDZrWXVQbW1PZTBnSkpzT0p3MUZW?=
 =?utf-8?B?cVBEd1RUWXdaOTV5bEUxc3dscDNHQWN5Q1FZUWdOOHRrcFZTaVBYYjRHRmFU?=
 =?utf-8?B?bWlFWWlCaDVYV3U3STZkaURHdzZkdkJzb1V1WG9TSU80dnovNXd6cG40ZEw3?=
 =?utf-8?B?Q2Nibkk0WllOUlRtTk0vdmgwZy9zaWM4VGRjM1BSRVo1NjhXWEw2QlNVOVRy?=
 =?utf-8?B?VW8vZFRwMHI2T0hTbnd0bklpeld1Z2Uyc0crZ2U0WGlldWF3TEtFbnlFUzhH?=
 =?utf-8?B?YSthdm81dWY5TlBYU2ZDMGVGeGJGbXZLb0JLOGFuTVljMFdHTDV0aDBlRnBk?=
 =?utf-8?B?bVYzdzJFSFVFc3JuU1hzMWY2MFoxT2tNditTQkE0VnNGdGhMU0duVmw5Sk1Z?=
 =?utf-8?B?YnVTa0swRWdWZlhpZXprKzFRMnJvZnZFREQ3ekgwaW81RnU1YlA3YldjM0lV?=
 =?utf-8?B?YnArdHdQeVNtMG1GZ0ZnZk5XVi92K1U1MzY5SU1QWGJpc0t0eTdMWExkUk1l?=
 =?utf-8?B?dlMzYUxvMm5yZnNZRUUrdkI3QUpTaWdFbC9jdzE4bjVpUTFFWHBMc2w3dHlr?=
 =?utf-8?B?dDBuOGFVZlN6azZKZ2UzUmRaeXpySU0rQlVTRHFyRGlYaWVoTFdLcjRreDRP?=
 =?utf-8?B?ZXVjdlNXRlFpWW10ZXJEeFlLN1RGVnpJVDNiRjFlWnJ4RWtMQzB2dkpKYVdL?=
 =?utf-8?B?MWlKQlZtUFlXdC9aRXZMMlBpQ0poODBnODBKbFlzeUhaQU9rcDB3c1A5YzMw?=
 =?utf-8?B?TjFVbWNHRHJXQVR1Wi9TZ1BRdkNvSlozcXUwWElZQXRsaFErOVdkMjR1Z1Ex?=
 =?utf-8?B?cm1nMmRBenhucW5nUXRSS3U1OTZuVGs5c3NGZFoyUnZFeUc3SkxZZFh5eGZC?=
 =?utf-8?B?Qko2eEo1VFQvVitxUkdwZUNnVGpOMHJrb2l6eXRYNHpiUDZaQzVtMisrbzhl?=
 =?utf-8?B?MHBSQVk3dGNaTHY4bmdPUGJGRUljQVhBMDFUMEZIcW82eFFDUW5JVS93U0ho?=
 =?utf-8?B?L0svL2RCcldrdkNZelgxV0dEeHNKM2RmZXp0U0JRVlh5VGo5MTZqRE5Odngz?=
 =?utf-8?B?QjgrWFJabVVnd0FteVE4ZGFzcS85Z1NQbXpmMHdTeVVOVG8yQ3Q1WHBKWkVQ?=
 =?utf-8?B?bTd6TkdRd21vVjdUQlJmejhiVUtWeDB1Z3ZhM3FDS1VGS0xtbXhIbnJ3YkM2?=
 =?utf-8?Q?jYLQ3Qk7QBmDm9t8lwPScwg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17c938c-972e-4bfd-05da-08dddaaf2086
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:19:45.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UkiOJSJg7+Tp5Pojcy2Fz/ehltykFpo7TX7zDAgaymKlIWU/rrdPrHHSrfHrikI5gJIB55hcPdVmboE99zPIvGGvHcyNtsRGP6VV1KPBiA5PFzqOtCnz88dZSUchFv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9390

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Up to UEFI spec 2.9, the type byte of CPER struct for ARM processor
was defined simply as:

Type at byte offset 4:

	- Cache error
	- TLB Error
	- Bus Error
	- Micro-architectural Error
	All other values are reserved

Yet, there was no information about how this would be encoded.

Spec 2.9A errata corrected it by defining:

	- Bit 1 - Cache Error
	- Bit 2 - TLB Error
	- Bit 3 - Bus Error
	- Bit 4 - Micro-architectural Error
	All other values are reserved

That actually aligns with the values already defined on older
versions at N.2.4.1. Generic Processor Error Section.

Spec 2.10 also preserve the same encoding as 2.9A.

Adjust CPER and GHES handling code for both generic and ARM
processors to properly handle UEFI 2.9A and 2.10 encoding.

Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/acpi/apei/ghes.c        | 16 ++++++++-----
 drivers/firmware/efi/cper-arm.c | 50 ++++++++++++++++++++---------------------
 include/linux/cper.h            | 10 ++++-----
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 99e25553fc1320b2306efb751e12f2377c86878a..79a128cb04c351c1d01ee749904ee844963d0f10 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -22,6 +22,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
@@ -531,6 +532,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
@@ -543,9 +545,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
 		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
 		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-		const char *error_type = "unknown error";
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
@@ -559,12 +560,15 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 			continue;
 		}
 
-		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
-			error_type = cper_proc_error_type_strs[err_info->type];
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
 
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Unhandled processor error type: %s\n",
-				    error_type);
+				    "Unhandled processor error type 0x%02x: %s%s\n",
+				    err_info->type, error_type,
+				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
 		p += err_info->length;
 	}
 
diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 6ff781e47147c05c784ca5aa57149d1435cb2467..76542a53e20275cf0f059e9ce409fd898de16d4d 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -93,15 +93,11 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	bool proc_context_corrupt, corrected, precise_pc, restartable_pc;
 	bool time_out, access_mode;
 
-	/* If the type is unknown, bail. */
-	if (type > CPER_ARM_MAX_TYPE)
-		return;
-
 	/*
 	 * Vendor type errors have error information values that are vendor
 	 * specific.
 	 */
-	if (type == CPER_ARM_VENDOR_ERROR)
+	if (type & CPER_ARM_VENDOR_ERROR)
 		return;
 
 	if (error_info & CPER_ARM_ERR_VALID_TRANSACTION_TYPE) {
@@ -116,43 +112,38 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	if (error_info & CPER_ARM_ERR_VALID_OPERATION_TYPE) {
 		op_type = ((error_info >> CPER_ARM_ERR_OPERATION_SHIFT)
 			   & CPER_ARM_ERR_OPERATION_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_cache_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%scache error, operation type: %s\n", pfx,
 				       arm_cache_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_TLB_ERROR:
+		}
+		if (type & CPER_ARM_TLB_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_tlb_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sTLB error, operation type: %s\n", pfx,
 				       arm_tlb_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_BUS_ERROR:
+		}
+		if (type & CPER_ARM_BUS_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_bus_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sbus error, operation type: %s\n", pfx,
 				       arm_bus_err_op_strs[op_type]);
 			}
-			break;
 		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_LEVEL) {
 		level = ((error_info >> CPER_ARM_ERR_LEVEL_SHIFT)
 			 & CPER_ARM_ERR_LEVEL_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR)
 			printk("%scache level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_TLB_ERROR:
+
+		if (type & CPER_ARM_TLB_ERROR)
 			printk("%sTLB level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_BUS_ERROR:
+
+		if (type & CPER_ARM_BUS_ERROR)
 			printk("%saffinity level at which the bus error occurred: %d\n",
 			       pfx, level);
-			break;
-		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_PROC_CONTEXT_CORRUPT) {
@@ -241,6 +232,7 @@ void cper_print_proc_arm(const char *pfx,
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
+	char error_type[120];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
@@ -289,9 +281,15 @@ void cper_print_proc_arm(const char *pfx,
 				       newpfx);
 		}
 
-		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
-			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
-			cper_proc_error_type_strs[err_info->type] : "unknown");
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
+
+		printk("%serror_type: 0x%02x: %s%s\n", newpfx, err_info->type,
+		       error_type,
+		       (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
+
 		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
 			printk("%serror_info: 0x%016llx\n", newpfx,
 			       err_info->error_info);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 58f40477c824e61c7f798978947bf1f441ce45ad..5b1236d8c65bb7d285a327c457115a18fc9d7953 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -297,11 +297,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
-#define CPER_ARM_CACHE_ERROR			0
-#define CPER_ARM_TLB_ERROR			1
-#define CPER_ARM_BUS_ERROR			2
-#define CPER_ARM_VENDOR_ERROR			3
-#define CPER_ARM_MAX_TYPE			CPER_ARM_VENDOR_ERROR
+#define CPER_ARM_ERR_TYPE_MASK			GENMASK(4,1)
+#define CPER_ARM_CACHE_ERROR			BIT(1)
+#define CPER_ARM_TLB_ERROR			BIT(2)
+#define CPER_ARM_BUS_ERROR			BIT(3)
+#define CPER_ARM_VENDOR_ERROR			BIT(4)
 
 #define CPER_ARM_ERR_VALID_TRANSACTION_TYPE	BIT(0)
 #define CPER_ARM_ERR_VALID_OPERATION_TYPE	BIT(1)

-- 
2.50.0


