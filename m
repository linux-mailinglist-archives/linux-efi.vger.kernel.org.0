Return-Path: <linux-efi+bounces-4545-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEE9B25527
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 23:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF5E7B3AD5
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB0C2F0C53;
	Wed, 13 Aug 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="e3FDaDwz"
X-Original-To: linux-efi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022130.outbound.protection.outlook.com [52.101.43.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E062D0612;
	Wed, 13 Aug 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119984; cv=fail; b=OESZC91EpdRP6Fqoqmquc/cPdj9uuETA2LMA2PM25fbGDHOtU8CiFvQW2WmwL4zI2gzmnB6Ey31Dn3WIW1swTZY/yKywLgIjivT9kx8mLjjuU77Yt1c4etFSbG7NAw4vFjPP3PSGdR66aO0w99oK87Dy11wbbZp5lre2aGPKD4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119984; c=relaxed/simple;
	bh=sc3gfZ4nGvKFVsMqS9gB29CNtupExAllNxPjSCI6Kno=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HkaHV+N9kQVBh/cywp+FD+PB/9SX3LTS+v0Ptq11BmUhy2hkmoM0En03oc+DsQ4B76BfjDkZGcqWHeox/QLvFZ7KgPVobv+runI1KxZekk4CuBeG7tmH6morXJk7JXDiTBFX3qsU4/XkDXsCIwmAbS8Z3qac7jIu94dp+qvzWU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=e3FDaDwz; arc=fail smtp.client-ip=52.101.43.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVE2N4WPQSSuolx5ACimMruEdsA8GXXI/tE+0RYcLErW4x6qH2iMFuDsHhPPrR92VFKKoO18GoKAVV1pP7ulfLYZP7uXB1g6rv1sriGxZVk7flwdCzUS95k1U3iOxxiDFuAhuTWb4JIHjTpKbmrHrZBnIqcXEB8i/snlAOBVHqXp3qnrX5jUz2wPJ+I3w0hNnZMEqfacOGrSA30gVZj90agEGLp6hPj2yfVztRkoZyhFlXew+ohTPZmyJbdw2uMg+sPnTC69UhBejzz7DVgXRF9Ofs204b+phGCbhMvJkqVMUO/Epwrl3HJN42/OIDwyJvSpYb9AIWFY+6caIka92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzwmSN7axjrbTpyKQElaA0AcHIs92Rj7KpGwamN7seM=;
 b=FrFvm9c8Dywgj4uNlNW5fVUkekM+CxzCkmqGqh+0oL8vAt94/46n8gCyt8caS7XDIj37kfVMdt8pCM24JtjZ4jCAMH79HaySGaaqsljFi8XT4paSCXD61Xkwu2OBlQmS3LZ67eDa2mFUSCv0JZuI6SOwPGF8fUfFdMHZQvSpkm1U/nrRkuOzmxv2JYF7wNn30huzomQfyAAk/G10QBsNBjVnOwiLJpkb/BJ4XhMAOhOSTGCS4S/XubfTC7d+sWmHbFssdGa91+tBR8FTBUIcj/vN1TSa2PoALXNWQU3KELeqhK0Tlp7lKonsBzkeQ9M1biysfz9mHctaUvm1ghADcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzwmSN7axjrbTpyKQElaA0AcHIs92Rj7KpGwamN7seM=;
 b=e3FDaDwzQrow0GQAJ2kz3rg4PdxDGltonrmrsUuYrWcZKrJS4Jf/Vco6gXlp4PoqdwZWvu1oSZuQMynP8dL/C3H2fMvUFSj8+S6e/93m8w48VRtzGuWueeMivc1CdlG0XioPM1LMJPFSq1aKsbRbZx2hRilIU7W/CG81xDs9SVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 SN4PR01MB7423.prod.exchangelabs.com (2603:10b6:806:1ea::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Wed, 13 Aug 2025 21:19:38 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:19:38 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Wed, 13 Aug 2025 14:19:14 -0700
Subject: [PATCH v5 1/5] RAS: Report all ARM processor CPER information to
 userspace
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-mauro_v3-v6-16-rev2-v5-1-954db8ccfbe6@os.amperecomputing.com>
References: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
In-Reply-To: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Jason Tian <jason@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CY5PR15CA0120.namprd15.prod.outlook.com
 (2603:10b6:930:68::9) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|SN4PR01MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: e456824a-b678-47e1-cb46-08dddaaf1c31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWpWbkhCdXNpakZIRjdEdUx2K2JtVnZVY2FrVHM3S1laODFxbG1zRHdiMzdn?=
 =?utf-8?B?a1grcU9TemVlU2oyU2wxY1hWYmlKU1pBdUQ2endPb1ZuaUVNOHRUd09jZkN1?=
 =?utf-8?B?UnFybjhtRHpmWUdHZS9mZHRtRE5aQ0xTMzJ2Y0F1M3luQ29RbHVyS1BUUzM3?=
 =?utf-8?B?dXcxTS9xVmI4OGYyUXloeVI5MnI5dy9JRnAvRHkxdWZFbXFaTHl4elhVdjB0?=
 =?utf-8?B?YnZFQ1ZCTGZWbFRLVnBFWDBwN1RRazhxdWFBN2VXNDhaQjVScDBvY0NvdXpW?=
 =?utf-8?B?RDAvVVE4VnpJSHNnSFprMWxxQ3htS0x6MGlreE1ET2lVakU5TTFsQ3lzbml2?=
 =?utf-8?B?czZRWjZWNkVsajZweUZCZHROUkRLM2pSbEgvYXd0Vk9lcFlLZy9ma1laWm5Y?=
 =?utf-8?B?SGd2azJTdTIwSS83NjJxOERWSEhyenZBc0hSS0hiWStNZnZWUENVNEplbGRR?=
 =?utf-8?B?Zk5pR2dSdGNOTFJNV0RURWJPS0tiOC9NKzhydkllZzUvOUFLUitiMHAwVnc2?=
 =?utf-8?B?MnhaQTR6OGNiN3l0VXNzRFNDdVNzaTArbEN0VllaV0pVV0ErM0xBVXlZQXdo?=
 =?utf-8?B?WXVRQ2dZUXBIVUFidElhS3NCTG1lLzZsalVId2NyQk5lcWZ3bXJYK0tGeFEv?=
 =?utf-8?B?dHF5U2pJdEtOQUYzVnZpS0hQbTVmTUVqcUJra0VkSWs0Z0pjaVFGQVFCMEdY?=
 =?utf-8?B?Y000ajNwSG9GTityL2ltb3RNdGN5T2VrajJxOEpCNXZVekg3MTUwckp0QWp6?=
 =?utf-8?B?TFZwSzN3OVQxTStFTDBVOWZyQ2ZvY3krYkw3RG9jL3pMRGI2S050N2dyNngw?=
 =?utf-8?B?R2kyQ3czVVhCOW1PenlvTEM3MlIyanBYazdEY0wrWjcvdWFKQXgxZ3A1VjZ1?=
 =?utf-8?B?RXpqQUUyOGNRVXI4MEtFTStick8wSFg1V1M4Z0pwUVVYYnp4L0dJd3lDK0xV?=
 =?utf-8?B?Y2pKcHVKQ05EcE41ZzVhZDJyWmI0b3JkelF6VE5ackIyRGhrNVNiOVF6bUo5?=
 =?utf-8?B?cTFWLzh2WUY4VWlLTG1zTjlzM0hPQkRFZjV6TFlTelM2MWE5YzRYOVl0TTYw?=
 =?utf-8?B?MWdwZzZNc0ZlMzJVaHJhSEZaRlltbjlkbjc0cU9LS2toai92VVYzdTNGdkU4?=
 =?utf-8?B?SUJvck42eFJGS3JIM3dreUJQcFJURXk0OStQWXd1ZFppYkRTblc3ODUydUJw?=
 =?utf-8?B?N1VxWExMRXc3WEQ2Y3ZoZmh2bW1jNDNjZjlSaFhtTGtBRUdkS3RoZXJyVkNF?=
 =?utf-8?B?YmtxSm53QTc4RCttMjNMbUNNUGZxYktQNUpqSVVySWpjTUZSZVkxeDJiUlRx?=
 =?utf-8?B?YzNsMFpROWVqL1VPSTBoUllDTjJtRmcvZFZDN2FWOGU1TU9KTWFjMjM3VnJY?=
 =?utf-8?B?RzU5aTFXMllnMkhsZE9WVUgrRnJvWlZLVHlDWEx6RXdxSEpSQW1TZmxERUdR?=
 =?utf-8?B?MndPZTlMRXgvZ2dqTDZ4ZHpqRUxWZHJmZHRyekl6c2xtZ0RoRTJ2cXpubFJL?=
 =?utf-8?B?UjlXaUVvWjBtdUdOdWh4L1JDZmJDTGJ2bVhGWlFTcDdWWWNKUU40MURRODJI?=
 =?utf-8?B?TDVwZE5mb05vQUdzcWFsb1RsSUlnY083bDlWdUdDc3RHY285M0REczlKcm9s?=
 =?utf-8?B?b3hRcnlTa0JKWUk5YjQ0bTVuNnVDSnVyeko0bjdsMmcyUUZmZmNlTXhpeFlJ?=
 =?utf-8?B?Vkw1R05MNkx1KzRFT2xSVUJSSC8wSVJpUTdnRFV3NEs3YTlvL3U3RXJnMTEr?=
 =?utf-8?B?alpLYU13NHVPUThPZTRSOHVBREdWQzlwYjdCNDhUWGJWS3hvSzNRZG1TWU43?=
 =?utf-8?B?b0FJZm9TZ1lGVUZyRXl4SEhINjIrNk9iZkFZNHhPVWNOK1N5VmpCaFZFUnJo?=
 =?utf-8?B?dWhyOHdSR2s3dExJQ1pJVmxJOHFubXdHL0JXVXpVYlA3N1hPTWVLYVdScDV4?=
 =?utf-8?Q?A2fRhrw5trM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xkYTlnNUpDemRhMzZsQ2lMWXdPclZrVnZzS09xMkdLOEJ3OHU3RkdVYVVq?=
 =?utf-8?B?c25WRk1wUllLZTRGZ2tUR0NWS0hlMVNCenBhZ3hTaWZYSzIrV1BLekxXazhq?=
 =?utf-8?B?Tjg2TURVODlWcUJiM05EaU9DZHlFdm1NZS9WVUVNV2U3dEdTRnRDME9MRmRC?=
 =?utf-8?B?aVh4UEhsbFNYMVk1MjFBZlJObDVEeFVWU2hrYjl0MFR4dnRNeWxZd0lTYzQx?=
 =?utf-8?B?cmw3UEg5MWxkMEd6NnVYMDF3R0xuSXRaT2hVQTJEbTRNNzM4Szd2eVk4aStO?=
 =?utf-8?B?TStDd2o4ay9GcFl3VU41T05Ic3VCcEpHMHgxMEpIQkt6Y3d4VnJFL211M3NE?=
 =?utf-8?B?Qm94N2FxRS9LREMzc0RWSkRLN2VtU2dNOWxUVk9BakdWRVBkTXpyMXpNanBQ?=
 =?utf-8?B?WmNCQ0NzWlBSeXB3aGtYemtNK2E3YU5mbkIwV3prd04vZDVwV0J5UlVDaFh5?=
 =?utf-8?B?aCtwOEhOdTkzeDJ4UHdiRUtwY1A4dThoL2svMzNsR1RlbTZsRytEdzZkSmhn?=
 =?utf-8?B?TVVTZFp1SldtcDRjb1R6WkZmSk5sMTM0S0g0Y2ducjVFL1RobC9XSjRMV0Q0?=
 =?utf-8?B?OXFReTg5dHk1K3pmY0F3Y3NHN096bkJXck5rekxSaXU2cW5kbm1JdGtaYktq?=
 =?utf-8?B?bnpyNml6TjdYamVRWGNYOGtKbEdnUmlRQlh0Ky9PN1lyYzRaRkluM3piTmdD?=
 =?utf-8?B?TXltME1aYllDelR5V0J6UEJJblorODFXMW04R0V4dVFUcSsxYUc1ZE1adGRJ?=
 =?utf-8?B?UGdGeGdUVlhVK3p2eXlML21iYXA4N1VBdklpRXZYWEdIOTFOMXFEbld5NUhz?=
 =?utf-8?B?ODFaelNSZWZ6SkNOSTdKdVQ4ZzN2MEJJVU1kUFBWS1V0UXRGWHovR2s5eGlw?=
 =?utf-8?B?bysyaVFLUGlWVy9tZ2FvaENyTksvRXg0Y3RmZ3lCTnFRYXVVbEhhOWU0TDdu?=
 =?utf-8?B?RXRIOHN2WnFyVjhUa1VHRkp3R1BrcEhocU9IUTkxdngzOWhoa0c5cnpzTnY5?=
 =?utf-8?B?K0J5MEkvcU56RkNqYmVKYW56TXJzcTllbHVKcnIwN2VWcjRDTmxjcUJFRGND?=
 =?utf-8?B?NTJIdkNsSTliZ3Q0Y0NVbkY5azdnMzVML3JnNDdaeERnL3d2Qm9NUUZ4Q3c1?=
 =?utf-8?B?QWc2UVVUaTdmMEowVlpuZnNGTHhqL1RDWXFPVENwUXpqMlM4Zm9nTzhldkRK?=
 =?utf-8?B?LzI3cHFTTGFvMzl6K2NXRDIzK0daQTF2V1JoQ3MvSHhzTW54SnQrNjltd21p?=
 =?utf-8?B?em81eVpHQmNqN1oyekZpU3VkNlpxL2JXZmZMRGdPVVNKRGZDSnRKRE5XcnBB?=
 =?utf-8?B?a0pwM01FUjJwd2cwR0RHYXoyZkl6OElWQWlhZEJQc2JEYnFhaFVZUlBQOGND?=
 =?utf-8?B?bUR3WUJrdXgzRmFIS3NvY2pQSktLelRqeWxoRGNCMHV0M1VONXJHQzBmL2lR?=
 =?utf-8?B?ZlJWemVSdjU5UGtzZ2VFaGtEaGY3aEhlRGY1MmlHbDNTUDJDY0NHVnFUZnlH?=
 =?utf-8?B?TVZpMldOcDJRaGp3N2tEaVJFUmJmV0pZTTdKR1JVbXlIUHd5NHJVVmlkOTEr?=
 =?utf-8?B?TDNmR1BRUkpOODliZ3dBS0Y3d0kwMjdlTXVsWSt5UHFhZHYydE9IVFR1VEs4?=
 =?utf-8?B?Z242OFJVcmIzaGFYUkRnWGhLbjBrUmNzUEFacnAxRHRWQlZ0akw2Zkx3Y1U3?=
 =?utf-8?B?NTZXWDFMeG45SmpGTDVjcW5MSGtIMGc0TTkvMitWcTVFNngwUWErcEgxQVMw?=
 =?utf-8?B?NWQrVkpmZFA1a3JBR3VRK1h4SlE4eXNJV2JKMDVlWWFJb1RHMG5UdlZDOWht?=
 =?utf-8?B?WGI0Vmxkb1dZTHlZRm5SVk81TDNJR3hJV0Y5akJ5R3FrcVV4c0k4cTFwUHU1?=
 =?utf-8?B?dERHWk54UVhqVytsNUV2b3gvczZIWGhaTmxsbjUzSkZWUHNKdEgrd3Y2dlVF?=
 =?utf-8?B?M1dyQ2JyTVFFT2hGL0ZaUlhENm9tMXY0STJhMXZsVUJJSU5QVzRhUkhnTEVQ?=
 =?utf-8?B?TmpadGo0K0Y4NDNhWmtBV1VTT1lBUkszVnE0ZWp3Q2dDcTdIUy8xbnNNVFpr?=
 =?utf-8?B?SE9FTWtxWUhrK2VpenRndlNnNTRqVWpqV2RFYTFvOHB3eTJPa0ZLQ01HRjZy?=
 =?utf-8?B?Ym9BTTBUU1grbjBzTzNYd2FBVURmck56dkNIRVdaeXdJbU5LdC9MWTdrTTdj?=
 =?utf-8?Q?+vK3krxeAC5hpXytQ1AgGGw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e456824a-b678-47e1-cb46-08dddaaf1c31
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:19:38.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNDtTWXDY3v8oOhMaW9ONxD5pgKrqyvsNGMVW6o+j7ZfrpukqcAs7AMMlzhqlaHs/SmP0A9IYNT9bq6/S+fbK2pWTbcrZMBZOcoQpeGq6M3+YmxkSgKVty1NxQvCM3zU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7423

From: Jason Tian <jason@os.amperecomputing.com>

The ARM processor CPER record was added in UEFI v2.6 and remained
unchanged up to v2.10.

Yet, the original arm_event trace code added by

  e9279e83ad1f ("trace, ras: add ARM processor error trace event")

is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
exporting any information from tables N.17 to N.29 of the record.

This is not enough for the user to be able to figure out what has
exactly happened or to take appropriate action.

According to the UEFI v2.9 specification chapter N2.4.4, the ARM
processor error section includes:

- several (ERR_INFO_NUM) ARM processor error information structures
  (Tables N.17 to N.20);
- several (CONTEXT_INFO_NUM) ARM processor context information
  structures (Tables N.21 to N.29);
- several vendor specific error information structures. The
  size is given by Section Length minus the size of the other
  fields.

In addition, it also exports two fields that are parsed by the GHES
driver when firmware reports it, e.g.:

- error severity
- CPU logical index

Report all of these information to userspace via a the ARM tracepoint so
that userspace can properly record the error and take decisions related
to CPU core isolation according to error severity and other info.

The updated ARM trace event now contains the following fields:

======================================  =============================
UEFI field on table N.16                ARM Processor trace fields
======================================  =============================
Validation                              handled when filling data for
                                        affinity MPIDR and running
                                        state.
ERR_INFO_NUM                            pei_len
CONTEXT_INFO_NUM                        ctx_len
Section Length                          indirectly reported by
                                        pei_len, ctx_len and oem_len
Error affinity level                    affinity
MPIDR_EL1                               mpidr
MIDR_EL1                                midr
Running State                           running_state
PSCI State                              psci_state
Processor Error Information Structure   pei_err - count at pei_len
Processor Context                       ctx_err- count at ctx_len
Vendor Specific Error Info              oem - count at oem_len
======================================  =============================

It should be noted that decoding of tables N.17 to N.29, if needed, will
be handled in userspace. That gives more flexibility, as there won't be
any need to flood the kernel with micro-architecture specific error
decoding.

Also, decoding the other fields require a complex logic, and should be
done for each of the several values inside the record field.  So, let
userspace daemons like rasdaemon decode them, parsing such tables and
having vendor-specific micro-architecture-specific decoders.

 [mchehab: modified description, solved merge conflicts and fixed coding style]

Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com> # rebased
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section
---
 drivers/acpi/apei/ghes.c | 11 ++++-------
 drivers/ras/ras.c        | 40 +++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 16 +++++++++++++---
 include/ras/ras_event.h  | 49 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad451915a2679c17f2367461c141663c5..99e25553fc1320b2306efb751e12f2377c86878a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -527,7 +527,7 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
 }
 
 static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
+				     int sev, bool sync)
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
@@ -535,9 +535,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	int sec_sev, i;
 	char *p;
 
-	log_arm_hw_error(err);
-
 	sec_sev = ghes_severity(gdata->error_severity);
+	log_arm_hw_error(err, sec_sev);
 	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
 		return false;
 
@@ -870,11 +869,9 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 			arch_apei_report_mem_error(sev, mem_err);
 			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e9239f44f29102a7cc058d64b93ef..c1b36a5601c4b12988089ad292ee5f1c5dc862d5 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -52,9 +52,45 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 {
-	trace_arm_event(err);
+	struct cper_arm_err_info *err_info;
+	struct cper_arm_ctx_info *ctx_info;
+	u8 *ven_err_data;
+	u32 ctx_len = 0;
+	int n, sz, cpu;
+	s32 vsei_len;
+	u32 pei_len;
+	u8 *pei_err, *ctx_err;
+
+	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
+	pei_err = (u8 *)(err + 1);
+
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
+	ctx_err = (u8 *)ctx_info;
+
+	for (n = 0; n < err->context_info_num; n++) {
+		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
+		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
+		ctx_len += sz;
+	}
+
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
+	if (vsei_len < 0) {
+		pr_warn(FW_BUG "section length: %d\n", err->section_length);
+		pr_warn(FW_BUG "section length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		vsei_len = 0;
+	}
+	ven_err_data = (u8 *)ctx_info;
+
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	if (cpu < 0)
+		cpu = -1;
+
+	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
 static int __init ras_init(void)
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad3f2b430c53c7a9e23e798a1c1fbe..468941bfe855f6a1e3471245d98df5ffb362385b 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -24,8 +24,7 @@ int __init parse_cec_param(char *str);
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
-
+void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -33,7 +32,7 @@ log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev) { return; }
 #endif
 
 struct atl_err {
@@ -53,4 +52,15 @@ static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+#include <asm/smp_plat.h>
+/*
+ * Include ARM-specific SMP header which provides a function mapping mpidr to
+ * CPU logical index.
+ */
+#define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
+#else
+#define GET_LOGICAL_INDEX(mpidr) -EINVAL
+#endif /* CONFIG_ARM || CONFIG_ARM64 */
+
 #endif /* __RAS_H__ */
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 14c9f943d53fb6cbadeef3f4b13e61470f0b5dee..ab217cc277c556b8847971c807ebbb587d5a29ce 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -168,11 +168,25 @@ TRACE_EVENT(mc_event,
  * This event is generated when hardware detects an ARM processor error
  * has occurred. UEFI 2.6 spec section N.2.4.4.
  */
+#define APEIL "ARM Processor Err Info data len"
+#define APEID "ARM Processor Err Info raw data"
+#define APECIL "ARM Processor Err Context Info data len"
+#define APECID "ARM Processor Err Context Info raw data"
+#define VSEIL "Vendor Specific Err Info data len"
+#define VSEID "Vendor Specific Err Info raw data"
 TRACE_EVENT(arm_event,
 
-	TP_PROTO(const struct cper_sec_proc_arm *proc),
+	TP_PROTO(const struct cper_sec_proc_arm *proc,
+		 const u8 *pei_err,
+		 const u32 pei_len,
+		 const u8 *ctx_err,
+		 const u32 ctx_len,
+		 const u8 *oem,
+		 const u32 oem_len,
+		 u8 sev,
+		 int cpu),
 
-	TP_ARGS(proc),
+	TP_ARGS(proc, pei_err, pei_len, ctx_err, ctx_len, oem, oem_len, sev, cpu),
 
 	TP_STRUCT__entry(
 		__field(u64, mpidr)
@@ -180,6 +194,14 @@ TRACE_EVENT(arm_event,
 		__field(u32, running_state)
 		__field(u32, psci_state)
 		__field(u8, affinity)
+		__field(u32, pei_len)
+		__dynamic_array(u8, pei_buf, pei_len)
+		__field(u32, ctx_len)
+		__dynamic_array(u8, ctx_buf, ctx_len)
+		__field(u32, oem_len)
+		__dynamic_array(u8, oem_buf, oem_len)
+		__field(u8, sev)
+		__field(int, cpu)
 	),
 
 	TP_fast_assign(
@@ -199,12 +221,29 @@ TRACE_EVENT(arm_event,
 			__entry->running_state = ~0;
 			__entry->psci_state = ~0;
 		}
+		__entry->pei_len = pei_len;
+		memcpy(__get_dynamic_array(pei_buf), pei_err, pei_len);
+		__entry->ctx_len = ctx_len;
+		memcpy(__get_dynamic_array(ctx_buf), ctx_err, ctx_len);
+		__entry->oem_len = oem_len;
+		memcpy(__get_dynamic_array(oem_buf), oem, oem_len);
+		__entry->sev = sev;
+		__entry->cpu = cpu;
 	),
 
-	TP_printk("affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
-		  "running state: %d; PSCI state: %d",
+	TP_printk("cpu: %d; error: %d; affinity level: %d; MPIDR: %016llx; MIDR: %016llx; "
+		  "running state: %d; PSCI state: %d; "
+		  "%s: %d; %s: %s; %s: %d; %s: %s; %s: %d; %s: %s",
+		  __entry->cpu,
+		  __entry->sev,
 		  __entry->affinity, __entry->mpidr, __entry->midr,
-		  __entry->running_state, __entry->psci_state)
+		  __entry->running_state, __entry->psci_state,
+		  APEIL, __entry->pei_len, APEID,
+		  __print_hex(__get_dynamic_array(pei_buf), __entry->pei_len),
+		  APECIL, __entry->ctx_len, APECID,
+		  __print_hex(__get_dynamic_array(ctx_buf), __entry->ctx_len),
+		  VSEIL, __entry->oem_len, VSEID,
+		  __print_hex(__get_dynamic_array(oem_buf), __entry->oem_len))
 );
 
 /*

-- 
2.50.0


