Return-Path: <linux-efi+bounces-6176-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOU0Ofz+lWkDYAIAu9opvQ
	(envelope-from <linux-efi+bounces-6176-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 19:03:40 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAC1587EA
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 19:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00C4D300D44E
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A29346A18;
	Wed, 18 Feb 2026 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bb9hQeyt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PwjkqWmG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19807346A05;
	Wed, 18 Feb 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437817; cv=fail; b=slUzLQ9fiSawLsZwmXX3MgHduxkYuO48O6798+00gHeOmu1l4pPzLsUwQAri29D7ShaYjbAdYGXPkSsdhDw6k+TRfdezqCsO2ABjT6Mt6uiy4s+m9xdfV5fPTyXMtgM4y/bNnF4ZIl3qzKeZ5/pFPJ/NSTIzObMWH9DGkLqKbB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437817; c=relaxed/simple;
	bh=SPg9YZzPpZmN+BgAghHgCAOc5+gOp2hYzRj5zMYKg3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kjr1jGOb0KE5gj5xxSTUWtY8oloJfxSuVfFc9obsJkfM0UaWYeYmdltJ9lIvkB2V6X5rSHzkrqsCVg+o9HSd4HG1jvbV63GA63oGIF0UlF9G3g5G/pvazR39GOU1VHJ1Y6Q/o0h4pUPOiY8IGjkdIn9l698mC5EtNS4A0TsjZDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bb9hQeyt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PwjkqWmG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IG3Jvc1290146;
	Wed, 18 Feb 2026 18:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qIVyhCS10fsY+cpDToukTJdXe8E9QT8siAHmLoZpM+g=; b=
	bb9hQeytNbWCp5qrGMS+4QHlVomh4FletHLl4DZAlkBv8R+TInXpdiaDUgA9IiOz
	6otBePBrrj06viSv2M2aGd5r8k5i5mka6bDiTYqbWwZOsEYc3hNzQ8LjA/38YCgp
	fG/X2DARDU/rEkjAGJGPjDA0O/3CeU5hWtBknPJ+nQDf2ztKLz1i9vEf2FxthdNS
	Zh4OLUFYk/Ez7dOGz5jXzkwckWJ9MY0q2Lg1Z6S8tMnlTGfvaaF3fos0rmk59Aac
	0rMsEe1MNMtYAUhTIBx8UnkJ1UNfwQ1Czq7fVbbpxO+8nhENGnizRQt5xVFKRZTL
	yQty9N5KiCptmrLb6pK+8g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0wp0hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 18:02:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHSMZX022887;
	Wed, 18 Feb 2026 18:02:24 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2dwcr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 18:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZNP+XmusG0z3GebipR/yFR03qZmQtqyFmW8dN8DPR/20kFn/0CQ8s9qe37ITg/WWT0Y6J8dph1Ni8avEpYVf9A+qWKSPPUzxmKSW94f8nRK41VxxU0gBdYJcOgpTyiwRNxnOgKU4o0sTz55u1l03kXDgfUn5fIciwFDAD9BtuHYgB4JIGp8B9ANhN67j42l+pIAUCAor+rrpfnKVVeZCONe1KQHPDeFVIH5sNhfNzLOgCopYbzE+jokkOrpo4RkIGuwjw42ju1wq7BQ7SpUNr2GalVKybF6iwqCDeMftRn8fNCpJdD6vlTDzWWV3mcFAeI9Sm5G4CfSieHAwTLC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIVyhCS10fsY+cpDToukTJdXe8E9QT8siAHmLoZpM+g=;
 b=tCqLCiBE9Tzqjq4so1V59Qlt6A9sBp8heM2JkJTh5gZYvlUPK2WQGi7wEYA5vNgYiEvGAgNjRRB10BZ4YdfEv9z1itvNaLVOU6UutKNoO3e6LHnWxjmQjGlzY32vpEYjsAfgglCgq8rjXT0ToSXYcRQ5C1GcszZnuPPG2LpGHP//vNirSv6zDjUnjkONvz11Qka9hMAByeZPb6e+XkWVSF7vv7P8FW4vIjBBDFoypM+9jEJSeqgqxvQDyZDhOJNC+nnGjZT6tZwGpDMJvxeUSDXwOH2untBsidoTlh0tJldEB7i4vqodctdOqeG6ZLKLxFiz4g2x1h0rpN6BWcydQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIVyhCS10fsY+cpDToukTJdXe8E9QT8siAHmLoZpM+g=;
 b=PwjkqWmGe0cXHsHnjf1n687AcYx9Cu7IeQWkQGXbxSeGzifE8NmPXRynDP5zTAKsT2r9Ye0WPgdGDEgmjRmalVJ4qkAXvDjAyw4TXV6HOSVC3HNlsRY/uLd2U4rWm0KY9bXR6K6dYI2Vf5k4tL+DvV7B/QVBjS2qBAE2xafWhdk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS4PPF72472EF09.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 18 Feb
 2026 18:02:18 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::30d0:8be0:725b:3e0e]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::30d0:8be0:725b:3e0e%5]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 18:02:18 +0000
Message-ID: <7f940bdb-21eb-44b1-9664-f0f99f46032b@oracle.com>
Date: Wed, 18 Feb 2026 10:02:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dave.hansen@linux.intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
        andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
 <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:510:5::15) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS4PPF72472EF09:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a31ae42-0bfe-43a3-f839-08de6f17db2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3daTTU4ZEIxTTlkZjMzV0FUVnBhdEN2Ny9uVjVNSzI0SjErMCtlMUtXZ2Ew?=
 =?utf-8?B?TWZLZ1JGd2pxMHFoZDBqZDZ2bkw3RThFZDF3ZGVqcHg0RE9RYytzNWlQYlhI?=
 =?utf-8?B?bVhETDZVMUk5Y29lODNQU2tWWmx3SU1VRnMxczQvcEFIU0p4c1dzS3hqWU82?=
 =?utf-8?B?blAzL296RVNwU25EMUFlL2wyQWI4RTUxaHNjSzJyYUpNdG53SGlVN2FUTS9n?=
 =?utf-8?B?VHVSeTRNczk4T2ExTVdUTTgwOS95VDFkT2tZcGdLbElBaVhJQ2Vra1JBeWJ1?=
 =?utf-8?B?OUJzWWo1cU5vaURNTmtsaFJwaWRXeDJQbHB6endCVUNVckdvK0xrV0ZQU2du?=
 =?utf-8?B?Vkl6T3Z6NE1MaTFQcVIrWndzT2cxeVkycWdRVGNUcDBFTjNuMXV1REV1cjY0?=
 =?utf-8?B?MC85WXdzNU5WYk1nd0JoZFJEcXFjVS9GckJYSjZGSzU1RmV6VWtydlpnM1Fx?=
 =?utf-8?B?Q3ZpeXN4WUg1cllQYlAvdnZjQkZzV1paRmNsUlZoYWwreTA0NG9DU1YwTG1j?=
 =?utf-8?B?Z3haTkI1bzJmWm81aG9qSDNzMTVoejJ5SlBxeTlNYy9wOU5aajBlUGcvczQx?=
 =?utf-8?B?cFBkV25Gc3lZdDV4ZG9UeHM4dC9lV0U5T0xQUE82eHp2cTI5bnBQK3UvYkhL?=
 =?utf-8?B?NXUxV2JJSkp4M2JSeWZjcUlUSytxZ2pJK2Rzek9aTVprdDJISXJZTUpzTkZ2?=
 =?utf-8?B?SVE4OG5tWFVDWkVJODJPVk1YQ0duVDZQMS9maEJsMGpyc1gwSUdFWHlRMGpk?=
 =?utf-8?B?Y1h1ZVRVMzJVVVc3OFgzRU9zQTVlaitUeG9SZHpyQzFvY0FLOVlJVzg3MDBD?=
 =?utf-8?B?Q2VMVVJzQXdsNnFQS0MzWE85YkJObHFPZlJ2ZCtUVjhLZEU4czJnNXNnVWMr?=
 =?utf-8?B?WlkvbVpDNE9NUXo4bWVWZDFCSDdqZ3c4ZDdZa0lkWnFnRm5IZ1dkdzN6bU4r?=
 =?utf-8?B?Y1pXZjdObFg2KzhsKzZzbjB0SElyblpMY1ZjTEdLbkVYcjZBYVdzZk44d3Q3?=
 =?utf-8?B?cU9YN1VsUjdKaG5UaWZUb05rQnREWDF5LzlrZHR4OTZtdVBBRFBDRVY4VTJm?=
 =?utf-8?B?bkFLZGFTRHdORlFPUmFwSXExV1NtSkh0N2lpaitiS09XYStmNklqazJhUVcx?=
 =?utf-8?B?eEZvalo1NkVHblJ3TlNsL2E4SCtYS3l1UTV0aktmWGMxZ1NFVk9sdFVtWnJF?=
 =?utf-8?B?a3VyWU4rWnB1V2VnMUQ2NGNvU3A2ZUs1eTBDSnJhaEdVZVVnU3FGc0l1b08w?=
 =?utf-8?B?Yld4dzZlNjhQTWQ4VzBIUjZoY3FpSlNMcmk0QVV0dVNzUnZWNGovMml4dUZZ?=
 =?utf-8?B?ZXhQaXUwcTdPN1JFNHEzR2VTcEFzWWpUYzlHRDlSNThkZFlwbktYMzNuT2RE?=
 =?utf-8?B?T2N2NWE2Q2RCOTIrZnZvSitWSGdxSnkwdmZMbklBVmdLRkYzdUE2TkoxNkgy?=
 =?utf-8?B?azR0RURqbzFpMHBkUmdtNnJGWWpDbFNIWFd3NTZOdHJHWUFRVHNMVmlkV0l4?=
 =?utf-8?B?VG1FcUhoa3cycXljYjJ4WEZxWkFhQ0g2YllRdXZuUXRaZXk0SGFuaEFiOS9z?=
 =?utf-8?B?aURHUGF4ZUdxb2d6TjkvNDRTWHJNdnFsRG9FS2xleFh4eG84dFgrY0IwVTJu?=
 =?utf-8?B?Z2Y5blJiQkw4QzBiV0M4Rks3bkRKWll0M21RSHd5aWVieDM4UDlFNjFkQitT?=
 =?utf-8?B?b0hEM1BlWlhJaTJkd0JMdGxiVjgxOEUwa2J2NjF6cS9sblhpRGNlamNmN1lS?=
 =?utf-8?B?a3MzY1hNN3hkK3BWWWwvSFQ4T2RPakZmTDJCNklRakFIMkNzcCszSlVBVWUw?=
 =?utf-8?B?KzNSRzg3MlNiKzVsQlF0SVNkZktGMHBNR0U4S1FaVnlSaTlhOENNU3pZdlVI?=
 =?utf-8?B?Q1BNd1hOaGpURm04TFljRWxPSlhZV1VTZzJPR1JLUTZuSkhYSXllV0JnTWZD?=
 =?utf-8?B?Ukx0bkUwRzFBNFNHMGhtdDFrcWxTRVVwRTVSTlpLaDRJWWJqdXpPcWliRzJX?=
 =?utf-8?B?WG5TNmZYcE1uTmloMjlXVHNPS2RtejZhL0hYdXdKWVBYcEpDaWZkcHVtWmVh?=
 =?utf-8?B?eWNFYkE0czdWUm5GaUphV24xa1Zpa2JvL0pNQlhlQ2VjcFdCYStZcUVnV0h2?=
 =?utf-8?B?Yk85RFMyOVI0aSsxOW5tb2pkak9BRzRmTldkZDV4U251SkFkTHc1YkdHTlha?=
 =?utf-8?B?cmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek1PSWowZU1hM3dUQUxjSk11TC9MYUhCTVA5cXZXcEphREcwWll2a1AwSzlQ?=
 =?utf-8?B?SHhDSHpiWDlDbkFPdzZlY3ZTT3dlbVVPNk9EbzVZSEdKRXdScG1QRGZqRElM?=
 =?utf-8?B?YnloQUNXV29ReGJtQXdtVUl3UDhOUkJqS1ZjMWhtVmNMWE5qYXdFZFdwNHpG?=
 =?utf-8?B?K2VVSEMzc1pWVmtXZnpaS0RBZzIyUGNTL213MVlzd1R3cTFTVHZtQTVxdDls?=
 =?utf-8?B?bzk3VmdxT3hJd1JDbXVmTHlkSlBEY1VmQXgxRzdGN3dFYTNyQy84NHV0b1d1?=
 =?utf-8?B?NDVZdlNCS1QwRFJKaXRKN2tBa3pXT285UnZKQmplVlhxUmpXQ2dDMUhKVzl6?=
 =?utf-8?B?bWgzNEp5d2VmSDAwRUZGekoxS3dZemdpdmJXTEhGUmVaZFNjQ1ozNUJlRG9D?=
 =?utf-8?B?SjRzMjZEWENpMlRxSHFaMUpqbEI5dkpjZmU5SWdlZG1lMk9wTTZtd0ZFTi9Z?=
 =?utf-8?B?NnpocUJFUXJTZVprdVZXOFcvenI2VmhEVmN6MmwyaTZnTEFVUjZ0cHI3bUE4?=
 =?utf-8?B?dXlSUWJ6ZFZNUFd1REdrSlA3NTZsa3ZpWWQ0SmRYK1pEKzFjK0dDcGhBN09s?=
 =?utf-8?B?Ylk4VmhoS0RGOWN4d2p0ZnN0ZWFGaU9FZFZGeEV2OEdzcDVKQitJZmhYWGR1?=
 =?utf-8?B?YXhQamVNNzRKbU1QL3F0RGR3eEh4U2ZSYVNkVzVtOGU1S0NUeEtHRklKVVFS?=
 =?utf-8?B?aVZDYkt6S1Avc3RybmVuc2dpY0lJTWpxMUJ0dzN0MlBaaHVLbC9EZXAreVdW?=
 =?utf-8?B?SEdEeENLS2RlbWtnb0hsK2tlS1lsR2RLRGI2a0xtOUZwbENVN1I5Nk9qZ1Rj?=
 =?utf-8?B?WjUxZHZVSGR2elN2dUkzVmkvL3hEUzNJb3Mwa1NNVWxlUngvSUlOcVJJaTRj?=
 =?utf-8?B?NEtBYVBOTG9ZN3p5MFI2ZU5UZDRBUUMySi9oR1lJZTBLQXpCNmxybzB0c1Iy?=
 =?utf-8?B?RG9QVWpFeG9OSTZGVmdvRTJUQXNTeVhqQmdyQlV2TlovRzBEV3FITGQ2VHQr?=
 =?utf-8?B?R3JQcVVVUUxndndYQ3pEb0lmUmxJYUxMUWdSbTFrNXpBMzJlRFFBd2JvSDdF?=
 =?utf-8?B?TGF1YmRSK21CbnZDSUxqOXdxYjA0cGhKNkdEVlFlMXUyWlFMYVR2WGVkWDV6?=
 =?utf-8?B?NjF1anE4V1JGVGNva2J2c2dFUXRGcm13eW95MnNyMmtLUmhpYW9nWEFtdVYv?=
 =?utf-8?B?NFJGTnRvZFU0N3JtYlJsREI5QVluZ1lKb2cvaDM4REFrMzVweVhmb0NqZkVx?=
 =?utf-8?B?bDB1dm1qT2l4RW1HRGZhTmdTRE9pTS94a3V5czZYNWpaRUdHdE1PVnUxbnZa?=
 =?utf-8?B?em42MHJ4WDBDQzVJcmZYa05ITE90S1prbWlsaGdCWjJpamdpT29DeXJEYzBy?=
 =?utf-8?B?N1BXckMzNlBQN05vQ2RsNVNvTy9JWFlMMW0yOE01UkVLZDd1UE8xVzQ1NjZz?=
 =?utf-8?B?WS9qbUh1eUpnbVZiWHVqc2dvT1RXenViTk9aWEg1M2s3WjFMNWxnS1d5cnpS?=
 =?utf-8?B?enl2L1RyN0FobmREc2o4ZzhLZllSV2xyQUN6alFUbTRycC9DSG9ZQlNxYnlX?=
 =?utf-8?B?cXhOYm9nYVh6UmVZL1hxYTVpYkV5bWNlakJQU1d1bTBTR0s5RlJYMmZJS2Zm?=
 =?utf-8?B?UkNxcHV5cEgwUUNzZTkxQXlNZEJmcW1zU3NzYm1haXhLTDlhR2JNb1AvdzIv?=
 =?utf-8?B?NzJWdVdOeFAzYXZXZG5MMzNuazN2bmw0QVlzTXBReTVhUXVmQnJDbU9BRWhp?=
 =?utf-8?B?UTN0ZXJQc3ZQUGFDRlZCbHN1ZzRmenZGSEE1Z20vT1pqb1oxaktwbEhDdnJ5?=
 =?utf-8?B?cXJRN0xSa0NPK0RvTlJicmpHN2hmeG9xSzd2VkhKckdqbVNWeTRCSXgyY0RM?=
 =?utf-8?B?eGN2eUs2WjlQMTNwZ2x2WTFpVVlNb2FmcnZ2K1BUVWordTJ5bVh3dHBzWWsz?=
 =?utf-8?B?QTFtY21BZ1EzZlczNHBtd215UUN5aGcycEZEcWlJOVJUVm1JTTEyRjV1bERI?=
 =?utf-8?B?VktHc2VIMlp0OHl2dU9ucEZvamNaSzJoemhOK3kvNCtwVlFpKzUzNHBhdWha?=
 =?utf-8?B?bnZQdkVCcnlVSE0wRncyRmtBZEdvcVRpQ2s3ZDlnM1U3Qy9YUG9jQWpuU3JB?=
 =?utf-8?B?Q2RqeGZJTXFsS2xOVjlGVWdFU0hBRG9vRW9JMk04cEZ0ZVQzcEYvd1U5ME52?=
 =?utf-8?B?MDZoTGYyWUozTm9XQ29BbkZWaEt2aGpBNHRoMlVJeEhGSFU2MFA3UDJtRHhB?=
 =?utf-8?B?T00yaW9jeWF3THlOb3NFQWNacXRDNGZJLyt0eEJsNnFEaWxTbmxOTEVLc0VT?=
 =?utf-8?B?MUV6OGNjTlA3b1pwakpxb0o5d1E5LzlpaS9UYms4SnVuOFREZHA3ZHJZUnl4?=
 =?utf-8?Q?IL3IFtYoKXzywbig=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSKZPAq04mELC57cyr5Vp1fCAu57X0HzMxdyqMd1J68w+sMGsPOKd7kSKXqmRmJ5O0rZhiAd0dBknOeAsQjeZRjhiwjoTNjmSEH0pqEIjIaMOxmHqYb2AVKAPCKE/s+FpwhWCtY1hjy3Ao3jHBykip3G4gM+ppymuttlQlNvNF0v/zWEnmsBzVzoUFKqlnxr2FhRkxIz3a/UdWVLkf5dlxpRygWZqXVygX/HoIvHtZCrLCxIKB+50UUD3BPeIGT52WDrvJhXCCS7AeuVvml636DWXE0MehAIrrzYcDG4ycBjdUXO305obhltII276Udu25mZiqGgvCk7Uis6ZsNWcuLNTvE+hcyHm2UMI5W9przH6TIHqgfaqVebqIqJdIUxydlsRGDkNkn5BTyWPRRci2emkyPyivF4bOvGIq3fRwzRa8wysAsnYf4OSeP/v3i3AAM6k444GKl4tUuwsIhIL+HfH1OO+nqgMBb25hsdP952SVPVdRoXqGwGPctwSVKLS04tLHnR0jT56ey4SED19iXr2fXNN+K95fydl0AqCeYWT1pxfcvaEG+v4IMe0mn/9cXc04i0s7HsgSNloCvaldXlJ2HoGpuyf+TROH292bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a31ae42-0bfe-43a3-f839-08de6f17db2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 18:02:18.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/sPUekNa6IjYuWh8Ica9FpxqIGBdr3Y3sxiEEvwaVBkZ2I3D/Y0s2QHBhCnq/1YMMK4o8dda2eDEVbbsyJXA6xahLZrrV7A/gZSV/3bdlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF72472EF09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180153
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE1NCBTYWx0ZWRfX3oLcaLQCtAXA
 KBlomXnVhJyOau4zVat8pWQC/gBHgMwIH6RvaXoYEIjE6TACUSiC8H/rx2CYux4GXPf2ORm+ydy
 R+BxXS7Ttvz2N8rWEGijt8GuW9YucemscQJxL9RuPvfIKAb5UwlKUWaZkhexaeZbgwn88ncinfy
 vG0WqJZgnYY0rTGcg6sbV9BIeQWQ0DXJrpd2J7DcTnsUWo5ZLFhbmiCtqLorcuvszm3xzXbRl96
 U9fEmHvgjlKfKiS2+odDLUMPm1jx0cRSZj6C/HnkWEr4WwlH95twQtezLxAjs/So/5tEaUsaLCj
 OrkPXGKt1EL7ppMpbzLzp9yGpyhHdMAVpFQwtwbr6t3i03Sx56kQmFHvOWHdqVEHoc7+eiC6Ddm
 pkBJb6ymP4Q3eJAJ8IawIbjwx4TWjlyObHkQYRlMIXAfpIZBZz9F5fE/oalFPHiVD1Ts7uXgReK
 eFI+HaRRSKMbSNVT/BKRif9quiWcAOF6Bot5DtfM=
X-Authority-Analysis: v=2.4 cv=ZMfaWH7b c=1 sm=1 tr=0 ts=6995feb1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ebIKsdRN8gNXCHqbjrEA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12254
X-Proofpoint-ORIG-GUID: eh9o1ieXnNW0KIDyXUfr82_knwkzBLhU
X-Proofpoint-GUID: eh9o1ieXnNW0KIDyXUfr82_knwkzBLhU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6176-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,zytor.com,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,linux.intel.com,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.philipson@oracle.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5CDAC1587EA
X-Rspamd-Action: no action

On 2/18/26 9:30 AM, 'Ard Biesheuvel' via trenchboot-devel wrote:
> On Thu, 12 Feb 2026, at 21:39, Ard Biesheuvel wrote:
>> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>>> On 2/9/26 09:04, Ard Biesheuvel wrote:
>> ...
>>>> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
>>>>
>>>> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
>>>> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
>>>> - the EFI stub executes and decompresses the kernel as usual
>>>> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
>>>> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
>>>>
>> ...
>>>
>>> I think this is a great approach for UEFI, though we need to reconcile
>>> this with non-UEFI situations such as booting under coreboot.
>>
>> There are two approaches that I think are feasible for coreboot in this model:
>>
>> - just unpack the ELF and boot that - there is already prior art for
>> that with Xen. We can stick the MLE header offset in an ELF note where
>> any loader can find it.
>>
>> - stick with the current approach as much as possible, i.e., disable
>> physical KASLR so that the decompressed kernel will end up right where
>> the decompressor was loaded, which allows much of the secure launch
>> preparation to be done as before. Only the final bits (including the
>> call into the ACM itself) need to be deferred, and we can propose a
>> generic mechanism for that via boot_params.
>>
>> I'm working on a prototype of the latter, but GRUB is an odd beast and
>> my x86 fu is weak.
>>
> 
> I've managed to get a working implementation of the legacy entrypoint, by repurposing the dl_handler() entrypoint you added for EFI [which no longer needs it in my version] as a callback for the legacy boot flow. This /should/ work for i386-coreboot too, but I have no way of testing it (I only tried 'slaunch --legacy-linux' using the x86_64-efi build).

Using that GRUB argument should cause GRUB to choose the legacy boot path. That is where we were going with things.

> 
> I've pushed the changes to the branches I mentioned previously in this thread.

I will pull your latest, thank you Ard

> 
> 
> 
>   
> 


