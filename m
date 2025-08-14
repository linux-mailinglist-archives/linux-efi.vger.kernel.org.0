Return-Path: <linux-efi+bounces-4558-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88244B26D21
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68610603D50
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE447301004;
	Thu, 14 Aug 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QdbPUgHX"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3ED3002BC;
	Thu, 14 Aug 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190399; cv=fail; b=DlNUuzrnq91DqK8G98BSg/grOJrlrctiIxWP8QEFs883VQqtKQWqPlUauU0tkuhTdKWeoM9+8bnxIi1xPX0hbiEJjmZQooCZK2hCq3A/oausOKXQm54r1wb4C3/yUYsrBlvMA0GiXtajwbHdKYArTgcaIpkFzHL5hIKPV5XWD4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190399; c=relaxed/simple;
	bh=VWmmZySvsC0NkQY8VVXYlfvIiROA6vS4HSNzWwgHstY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HRnye2Kiy6z+QBtldwC2vSi9IiwyMDBrSgwVo9onV0QEplCXC7m+AeLaurW+FtiYufv9lae1J3KIJ2jovaG7cWskU+/6cDeZi+Dp4kmzmayQ4ZF/W1DI+7M7gDOG4pgrRDs/HzhfH4xOjYhvwOPFDAabE5D5BEZZ8H1QNl7gL04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QdbPUgHX; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnUQG1AvMIbVZIEt3HLDUoMnyv7dJKypwKK2io8B/YCu1Zbfoah3JVW6ANozj99+wN2EAUHDJha6AMOEfYDX3XBbdVJAA2lwVOPg0t9F0CwBmuN7jJquOzwbEkH159kj6qY1yfFoa6Ja9uggvnMdisG+ok8pHzW1VJgD+jNGplKw8wg0aGeBXikcu2AIvTqik78eLTuTwe1mh1ft2n0kxqi3YGWMX/2QQG/CWfwqlPWykWU/I+JbrrEDGBNf7ruC7V+VW0DT/BJoHerDpK2azgvNfRgH3VhVP/yNXHEfcaw356efWI0kRIthFeusa+Ujs0WoFovztTDh5MwCFlA48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ONZ6VMxeM/i9fNQr6Ks14ia8iihRqfgfE9CGNxrxYY=;
 b=juhRIJ9rutkZ7kINAdJpIS3MGEBWK5G+uMebHkynpOp0aZKdkQ6+THsqzk/KPpkczsEFyidu0+jmiSDTNllqRpp/NG+MKex3H3blcS08UP7iOQLFdcsDfO7onu627wugFfiVx9TNf543Tqf0QBPc1IdBhQq4vCuXF3kVWFcG8TzJrCrjgWwCwghkNA0mCXJR9vZ7xr9SV30k5BA+6AmdLvs6QjDO48YCZO654jbi/VztMSI9iRhhQLjfM8NSrsk4Uj3nCnozRJLkte0rta+2ALn+gTx9r+zk+W8cTu5M8roAA0iqBWlak8ce93RmSuZNpXB6dzLfmRbCFTf9mKJWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ONZ6VMxeM/i9fNQr6Ks14ia8iihRqfgfE9CGNxrxYY=;
 b=QdbPUgHXUPBojQppI/N2moFV0sG5L9e6wYTl7JIqE1mVwyd9Wo4XoqHijehY/GPKfNogbKwWFc9VUDOk3nKNfnNDcVbNWnI2Ow6Szxaf2IIes9QmnNUu41K1x3XOndOB4q1CPdqjTgQACIXVNHmtxgdDRZlK8n6u2HIyJuLv1UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 BL3PR01MB6881.prod.exchangelabs.com (2603:10b6:208:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 16:53:15 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:53:15 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 14 Aug 2025 09:52:56 -0700
Subject: [PATCH v6 5/5] docs: efi: add CPER functions to driver-api
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-mauro_v3-v6-16-rev2-v6-5-e5538d534aa0@os.amperecomputing.com>
References: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
In-Reply-To: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
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
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|BL3PR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 69718704-0e44-4da5-88e2-08dddb531030
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUdRdjRnU0ZLbVlZQTBFbnEzaFR2RzBGdlVPNGNET3ozOUROKzl3dEVtODNu?=
 =?utf-8?B?Q3gyVmxweGp3bFpsZzZNalBvMVdqeFRadHhaZW5xTmRNc0xQVUphakt5UDhW?=
 =?utf-8?B?QVQ0WjE2VDkwRVNoZ0pEdDJubzhoMlBRcmZMZzVlUDBqY0ZVRFJOd21FL1Ev?=
 =?utf-8?B?VHh4aDYvVGNPYUFmZXJ1Nk5xYlFWN1BoWnd1eDZoTExoellFb1BSZWNtRW0w?=
 =?utf-8?B?TzBJOWx5Yi9Fd3NsMHdsNXJ3RGpsRGpzdElPQi9XVDFrYTFNdWxvUVdDcVdw?=
 =?utf-8?B?Y3ZkNTVkQThYUzRuUC9SQUI4ZlFCOFF6TUpiZnpxS2VXVjZPUW9TZndhaHRm?=
 =?utf-8?B?dW1oMi9RQWM3aDZIVlZDZmZNeW8zdWhDSU9PM0N5ckVPUGt4Sk5ycTRNUjRL?=
 =?utf-8?B?N05EaHJIZThhcXl0WjBCd0Q0cUR0cmxKaWMvVy9sSzRwejFpcjFNUHQ3V08y?=
 =?utf-8?B?QWY5TTNQTjNKYVFMNHkrUDlMSVN5Ykw1Tlo3SDgzb0ZtUDhpcnBBc0x3eC9T?=
 =?utf-8?B?elhQL21vRkwyYTVqdXVDNlNURm5ZaTdOL1pnd1RUR29wc05PMUhJVGZzTmtX?=
 =?utf-8?B?T3FpTlBNWVdpZHNjVnBuTTBqcnlYS3lDWnZqeENUa3JEamNETFo3TXEzQjB0?=
 =?utf-8?B?MCtKL011OThuMEl1YSt2dHd5RXFsazhKd0dscEJRV1FQaWhiaHB3Y0swTWM0?=
 =?utf-8?B?Uml6UE1lU2tVN1lNVHFCa3V0VFlwYzQ0STFUTnc2MHFjS09DSDlhY05iWFJM?=
 =?utf-8?B?Y0RqazNKVHhPbE5GeDBVelNuVm1lOVMreEMyZ2F6bkR4cytjcHRhbVVHNGNk?=
 =?utf-8?B?dXJLMVAvNUVlNTdMQi9HMXVwMVk2R0dtdmZNWjdnTHVLb1B0TXhseDVZbU5z?=
 =?utf-8?B?YlI1NUNvaElmWVFSK1JQUDlnMVM2QzdJb2ZYZ0lxdG5PTDExMkNQWmZsQldQ?=
 =?utf-8?B?TzVuc29JaDQwOHJHYXorbUhpeWlxU1JueE1YVzkxa3pUbUdXenF0VHk1b2hO?=
 =?utf-8?B?dko3bThYRWtxZVB2TzFUUVZVNU5KTXBUZXg0NlFFVEp4QUlKQ0QxZkVqL0Ru?=
 =?utf-8?B?MzJrMnRnZ0pETUN5UWxtNTZVOUdhTzJsbXc3a21PdC9IdUU2UUNTYnczL3Nl?=
 =?utf-8?B?TmtHbWRGeFFCNER2OHlmT0M1cjdHbWZxS3p3Q0hTNnBtMFhGdkxKRW1lL1A1?=
 =?utf-8?B?LzZXWTJhUThCbVFuaUVyZy9ESFNXaUpKNjdnaVg0N0syVnAxQXRxOVpEOW9T?=
 =?utf-8?B?YzE1bXp4d1I3aTcrc3dtb2ROUEJYVzd5cXBMUTV5YW5ZQ1Qwc05FRGtqUzdU?=
 =?utf-8?B?LzJIcUgrNTQ0ZjhMMDJsSHk5ZVUzWUtmdXoyb2N2SHhBL3ZKRFFoYlVwdmtk?=
 =?utf-8?B?MGNmcjNVYmwyVWRPUWZBckV1S0hDZmhmT3p0SGlpWktTbTIzc3RIOXlCblhD?=
 =?utf-8?B?Mm5JWEFJbXc2YW1zUGxSTmdUZkczWjE4NDdDT2lVZDlRZWVJRDVLTHowUEZp?=
 =?utf-8?B?NzhEcWZzbHpuWDVzQ2tudVFxY2pvLzhyQW1WMnJtMmdJcjdXOWdEZGEyTW10?=
 =?utf-8?B?clpmQ0Y3SUIvdy9LM1cvekg2Z3RNNzFrYmpkY1FXcTNMZm9QR3lya1ZTM1hP?=
 =?utf-8?B?c0FXSmdCUU9MczgvZkVYcjFyWTZBdFFLTzRQRE5RbDIybldmSEl3S3pka2I5?=
 =?utf-8?B?VXVDSkpwb1ZHNldnenNxWTAwMTQvRjcrUDQxUjROU1Nwb2lzM1Ztemx5OFNE?=
 =?utf-8?B?RzJxRHJLOUE5aCs4VTdkdm1YTTRuSDlneVh6QlMzcjF5TzVuUFRGK1NwODBY?=
 =?utf-8?B?eFRhV3pMbHd5c0dlazU1eXliY0VYbkFPWHAxUkdXS2syR0VFUmZHTHE2Q1lu?=
 =?utf-8?B?ZjBvOUN4VmFxRWNGLy9RSEVhZU5zKzY0MFFqMDV3b3cyS0hJQlBoc0E2YmFt?=
 =?utf-8?B?RURDMVNWWXJkQVdMQW9saGowWlA5RjIxTTBKZXE4bnozN1F4V0RhRlErNFhG?=
 =?utf-8?B?WUFvMmV2SzFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWdNVmhETTJHcy9iNnlmRUVNSW5sazRQcXhWOEF6UWg1UGZmaGY5NVZHT0tl?=
 =?utf-8?B?MWRPY0lWZTdpVzdwbnl4Q29zUmg0M201Qnh4SUt1TFYzQ3NxUHdCR0VjaW9K?=
 =?utf-8?B?MXpUaTdJT3RmWGdVdHpjYk0raW83ZXoxZTZSMFEyNTdOdUNPc0xkbHg2ZWw3?=
 =?utf-8?B?RnRhSi9sbzJCS2haclVDMVo2R2lBNGZpb2tRNFNpclpnWWlVYS9qL0NFT1BJ?=
 =?utf-8?B?bW9Vam43SjUyblpnTDBDbFpZaHMzanM0UVJTeW1zZk9jTFJET3VUWTc3eGE3?=
 =?utf-8?B?cW9OaGd0dFRIMi8wdlB3V0Nyc2VqRDUrYVFGVVc2djFyVzFxRUNOV016L0Vz?=
 =?utf-8?B?RHRuRXJya2pMZFNudktPOHJraXV2Z0dpUmFvU2t3T2FhTzMwcGQxN3RYNGdi?=
 =?utf-8?B?cW9NRUQ3WHlTMVluZDBoQ001cFIranRIVDcrK1dwQnpWT2NrTkEwVmZGdDZE?=
 =?utf-8?B?K2JXWm1PdzBkb3J3SDhadlBLUmh3b0krQUJxTnpoU1FGcGVPQmkrcTJ5bEdk?=
 =?utf-8?B?ZCt6QkQ2eUVlekJPdjV5ZXJ4d2t2TnhPeE1ONXFRaC9zekplTHlqbVR0dEhq?=
 =?utf-8?B?QVdnZEVXS1BWTm9Ec3hRdDBZc3JkU0R1czRmVVh2QUhjanJCRk8xRVlrZ0k5?=
 =?utf-8?B?UlVlZm9EQWZDNitDVHJROUM2eWE2THNCc3VnbVMvUFo5YTlXeEFwV1pTY3Z1?=
 =?utf-8?B?UEtXdERuVDUxWEFTa0JpdDcwLy9sU0NadUM2WjNkZUFCUmFmU0VaSHF6RVhL?=
 =?utf-8?B?NUdqbmx4VithdE9vSEtROTYrNktHRnNQNnJsS1BLRDdmbzRWRnBQWGVjMk5C?=
 =?utf-8?B?cmJYSzA3NUhKQUFKdnY1WUdnVVdBUlQ1Z2NpVlkwNVBNdHUydlovVzdMQ2tM?=
 =?utf-8?B?NVlzWVBBOXFYeUJwQW9udERHb2lSS3RLRTdqQVlNcmpDcmNRL0IxSktFSk9h?=
 =?utf-8?B?RlFpMVBWaHZsRENrbnlWSm42RW1EcmxtTmpYN0tOT2dJaGk0cGR1ZDJjWlpG?=
 =?utf-8?B?SENmM0hvQUtWeDJBeVZUcy9pSGtqUjlsa0xNQlVtWjdwakhxM09NY0x6STJw?=
 =?utf-8?B?WWpLYWpRWG5xaktPd2Fwb1lveGt1V3Vsb3ArZzJPRlJJN3JNbmRRTnh4c3hE?=
 =?utf-8?B?UENwcUxUOFVDSk1wN2tiMWZodmVUTER5a1c3UVAxNlJqRlRqWlhSdG1KRSs2?=
 =?utf-8?B?SmRDeEhGeTBIWkVSbWdIZ1MzelVsbmM3b2s0TDAyUi9EQmpsOFNTOU1uZ3BE?=
 =?utf-8?B?UkRMejlrVS9DWUFhM3BqTG9zSnVocW85Mm10azNxRkJJWDVvbW9McEpFYnpu?=
 =?utf-8?B?emVmQ3Q1UE1LMDRKL0JNS29vL0tIYlJHRUl3bFlGVjZCajF4TU1yZjNhbE51?=
 =?utf-8?B?UDh0QVNISmI0d3BqSFY1YnFFcVFXcUp1TWZYbno1dnNzdk9kdllBZVpKcFB5?=
 =?utf-8?B?TzFjZFZ0M3ZLSzQwL3p5UjE4MXhNYzQrZ01SSlQyS2UreFRIU0t0aTFBL21W?=
 =?utf-8?B?dkZnNWRNUkZBcCt3TzZKQ0E5cUJlcnJYdGtHTHZFblc5NWtSWFNMZ2I0cEtn?=
 =?utf-8?B?elg1cDM5ZWdXSHc4bytma2lKNDNUYW5Scm1DalpCRGlxOE90YVY5RHB6dm5C?=
 =?utf-8?B?VFdUeDRVM2REeWQ1TFZZc3ByZFdUTTc5K2poSlVKUExmY3E2dWpsNW91V0NN?=
 =?utf-8?B?VnBWOG1TeW5IK21iRWtMdVp0d2gxT2VPdHFqb0c1a2Vtc2pXanpRSUJJU2sy?=
 =?utf-8?B?N2pocWJ4N1ozQ3Q1blpYR0lSZDVkcm4yYU1ncFVEcHQxU3g2cStpcmNacllu?=
 =?utf-8?B?Rmk2SjRoUUFHTWMycWRYcHg3NUJNdnZpejIxenlsbVhhS1JGR3hZUXJvNVVL?=
 =?utf-8?B?RitUTWRXOW1jRlkzbi9PZ0xZck1QSFRsZUlDemVmbk1hbXNRcEdyNUtnell4?=
 =?utf-8?B?RmdhWXkyeGRrNmFpQ1B6ZS9aUDNTWGV1YWtCdDZ6TDdobDNxbFYweU44Yy9U?=
 =?utf-8?B?RjN5a0FUR2MwaUpmQmx2cm9Ec0dSVy9xcjdLT3pJK3RMSXlMc1lKblh2WHR6?=
 =?utf-8?B?ZFdLYVYwLzJuWHlkd1o3bDRoS1ZiTHRsYlorcjRlblpzTGxsc1EzSFp2OStj?=
 =?utf-8?B?bDRrcVZyTUFRclVtODZZYnpJd1BGRWt5WG8rZzlENmlLUDhHMzFKZkpxWE0y?=
 =?utf-8?Q?VRTR2A6TiAWBH3Ea5WJFp/w=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69718704-0e44-4da5-88e2-08dddb531030
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:53:15.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY8ZLNlUjuOwY+IBbKaN2ey8oc/Tlg6LrM544lqKFs2A18tPuboKxEItqFPKM/fkkZan2a+uaY3sJlMAGuR0FdM04f2FN/2yQl8HWr6m5N4kc1i4hbEAuAqmED8gc5e4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6881

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are two kernel-doc like descriptions at cper, which is used
by other parts of cper and on ghes driver. They both have kernel-doc
like descriptions.

Change the tags for them to be actual kernel-doc tags and add them
to the driver-api documentaion at the UEFI section.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/driver-api/firmware/efi/index.rst | 11 ++++++++---
 drivers/firmware/efi/cper.c                     |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentation/driver-api/firmware/efi/index.rst
index 4fe8abba9fc6bf8ed53443e48e79285730871c32..5a6b6229592c9a9d1eb223966c582e0969ee9514 100644
--- a/Documentation/driver-api/firmware/efi/index.rst
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -1,11 +1,16 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-============
-UEFI Support
-============
+====================================================
+Unified Extensible Firmware Interface (UEFI) Support
+====================================================
 
 UEFI stub library functions
 ===========================
 
 .. kernel-doc:: drivers/firmware/efi/libstub/mem.c
    :internal:
+
+UEFI Common Platform Error Record (CPER) functions
+==================================================
+
+.. kernel-doc:: drivers/firmware/efi/cper.c
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 79ba688a64f8da7af2dad097b9331c72afc73864..0232bd040f61c9b4521ae50ec4b6a1b0bfa5cc19 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -70,7 +70,7 @@ const char *cper_severity_str(unsigned int severity)
 }
 EXPORT_SYMBOL_GPL(cper_severity_str);
 
-/*
+/**
  * cper_print_bits - print strings for set bits
  * @pfx: prefix for each line, including log level and prefix string
  * @bits: bit mask

-- 
2.50.0


