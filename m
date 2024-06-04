Return-Path: <linux-efi+bounces-1126-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F608FBA37
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6032F1F2290C
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38471149C7D;
	Tue,  4 Jun 2024 17:23:19 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D764149C58;
	Tue,  4 Jun 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521799; cv=fail; b=WCPKTghpsTrMzYYzrFbWwKXuZGjGu9Hcv8nlrcdIBE+RP6n4Bj1VnF7FPb+P71VJC/b8AdmZ46i0rm9fF0P0K4lmKdmy/NC9RiOxxGM+yVYPA3Eq/CrS5if+0g/uiudgbbaIVfJGXJXI4d8yL4ZQd+wcM1vmI1sFlCZiuG1qnU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521799; c=relaxed/simple;
	bh=A2lcTMMJB7jzu+Gj+ade8g8L4VcpUWzUGYcNaNYAJ/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwBl15firJ8zKYF1vrBCrixs6ObjWbOz1uWQ0yBswoAUev2bdc2KzXBKl9iIBxi6RYj8KGpe7jbs2/wRwf9mVfFgh6S0/SCdZutVDj8mJUASk1yJGcy2rZSr/4F3stEXjryIgLadiwApAFcDa/9LkwGTtfO91o9e6V0NkHR+1MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bmnhe004632;
	Tue, 4 Jun 2024 17:22:40 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DZemZGsYGDBP7381T4/E2xJwQ0ydRGEPMEUYZv+DfZ8E=3D;_b?=
 =?UTF-8?Q?=3DnKp9ydYgZ/BMfoGOTqDjbafOkIz/Co8xwvwFH7u5IMCHfumDq3O4AKW3xGRw?=
 =?UTF-8?Q?cdkKzuyG_IRntA2fjRdtp6QRJqSJeY7ikW5Ibct5Ons+2GGQ42lxIdOo9mT38ct?=
 =?UTF-8?Q?NyVaCxiOpRgj2H_DN2V6NiAj3V+Sf+tuPWAgLthEawelVwNyC87RKotaqfPmWEm?=
 =?UTF-8?Q?hR5KI/K2zBrKRKBD6jiJ_xt/LOOuOXI8m5/7irv9L6NWh3hbqSZktSwEGkykzvg?=
 =?UTF-8?Q?yYc64XEfe/2C+xIFuw7NhguL4H_AtJwGUsV2wo971LZakhvG3RpIFfzNYx0V98o?=
 =?UTF-8?Q?49biHDE+20WbraXpVBJQEZesJYCQgl2d_dQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv05djxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:22:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454GLXRS020545;
	Tue, 4 Jun 2024 17:22:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj2auns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:22:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dz0tq4ax57z80LQZT3hW3/RYJzm7ifo+TFFWYzu7xcUVWQAsHgG+73/ZjQ50QgBosqDQBF0VKznopM0kxHRu4dpZxbMyXaRDzfB6QdSDf4TFJiB17i65pKBVPoHUH0E8ZrLze1qcjwTNTWRCwdHf7KQobTocXiO6Cnyla17L6YrWvJXGU4VuLFrHJ30QLeId0fx/petVaaYP7SLCwgeXrrPFU5GpggMVQMYPpjYVe2SzqMsvK/89HWpswEbJ3Y3BOCUuxXGwv81/xgzXMHAFdt+xA8suHm3HSmjai9znbLO7kWA5w5g1TZNaqjsRhfqFE2/fNZ30WxXqPd9fTszlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZemZGsYGDBP7381T4/E2xJwQ0ydRGEPMEUYZv+DfZ8E=;
 b=AyDLMPer/23eMor5bt02TKbDBTc+Lm0oj5se8qS0foPLXLMtYzk1IgfPOmzTDmrq3l1FwbQJNoYfEa3Vz3z0MF2GAp1gwD6rT+b4U+m8efDV6pMcjxRC9kbd2xSMcrAQyplzqxD1Fath9rCwQzweNxxNKf2YqOdmffRWWyKMFXBASoby9uA4N87RBJI7KE1FwJfRyKMDp9Z6WjZ4HIgaoEZyL/oe0q0K4QwQdOXEg1XxIiWssUd8lGRtMyYzVQV4+p8YkLGkSvT/XCukiP4DO06DABeKL31RNln24ybZZUsNTxgkahEGbJLXAH9a2jel1MIRSRiiP9TfnmOxbji1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZemZGsYGDBP7381T4/E2xJwQ0ydRGEPMEUYZv+DfZ8E=;
 b=Y0w3EQKDW3TrdycjBIzhg00dcVPyIZUkzH3Ol4zdt28sMCSbQjlnSA/xQb5FmK/FNEOWvTKhud0nrFutfgWogQvZQrN2ibwi7xuwLu0ZGHhq0bSo6C6K1Y/S3kYwyBZZqreZ7TVuSaDhzIr1mkRZriZUrjAJi86+j3azygQdcp8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 17:22:33 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:22:33 +0000
Message-ID: <d6ec13f6-85ad-4c2e-a91e-36b834e30ffd@oracle.com>
Date: Tue, 4 Jun 2024 10:22:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/19] x86: EFI stub DRTM launch support for Secure
 Launch
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-20-ross.philipson@oracle.com>
 <CAMj1kXGC7a5+5at7T7M_mxBNWjqnuM4QGydG4ZEbu63y6fri3g@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXGC7a5+5at7T7M_mxBNWjqnuM4QGydG4ZEbu63y6fri3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e60858-4d2a-4eb1-43c4-08dc84baeb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVYwWUNVQVUrVEpqcEY0aXZxQXhkNVlJNG5sWDhGem5zR1B3ZzMyMUgydXdE?=
 =?utf-8?B?MGUxbEZ4MERMR29Dc1c3N3FpN2RYWUkrUWErV2QrcVRxNEVDbDZoRi9IVXh4?=
 =?utf-8?B?Uk4yT2RYNXc5NWZwL1dxSUo2UU5lZmRQOXBIUFJKZ3VIZlRHOUcrcVlUZnAr?=
 =?utf-8?B?THV4UVoxdHh2NnVLY3lsTy9LdHl6MDdRckVBdkV5dXlJK09jTk9DUGh4Q3lu?=
 =?utf-8?B?TDlaLzdMNEZMQkpURjNwS2p2N2NxR2hBd2h3dDJibTNGdkxZdFdHSmY4TTBl?=
 =?utf-8?B?ak85N0d1ODRFZGNJcUtMd1M2dk85V3RWVHF6bG9pREwvZ2h2NXNCYThGVkxG?=
 =?utf-8?B?SFZyczhEVlU3OC9CWFViVzQ0Mzg1QjYvS3pjN0w4Y1Y5OVlLb2F3d1pzQVlS?=
 =?utf-8?B?NEV2T2hJNzUwOG93OUZoekNqWXlaLzh2YWsrbDE3WFdCU2diTmVvU0VhZGJX?=
 =?utf-8?B?V1pmeUoxQllGUWxFYjl2WWxKYXFIZWxJNHorak1WUUlFR1A3UE1qdENZSXFs?=
 =?utf-8?B?OUk4eHlVYkpyVkVwTTRIUHdpUUZraVVoYW9Zak1SRjZDQWlQcmNsYk9DUFNR?=
 =?utf-8?B?dVZZbHc2ckZnSXR0amw2UGpHVzMrOWFGMlV4aGJ5M0x5SzFIeDVqblZMZmlY?=
 =?utf-8?B?bUY1MlR0QU1tUW1GV1dBeXVKZE1KdWxSVVRkekYwZXhCeWFsZTI4eXlzYnNL?=
 =?utf-8?B?L1djdGg4SDVHM0NEL0cweXk2NCt1elJwVWl0UjNhK29jT1VZWVZnS2RpQzBx?=
 =?utf-8?B?bWkwS1BWUkZWS3ZvWTgxTFVHSHBDSVZZcmxSbG1MT2NiK081VSthekFPQ3FI?=
 =?utf-8?B?ZlNMcEFlOFkwSTg4Y1M1UUxQS3RNZkttdGs2R0c5eFlqQnVZcGNYU0FIdDF4?=
 =?utf-8?B?L1ArOWVCSFdQQ2wra0o0dFlPdC9hakpjcVRVTU4zSm43WlBuQWV6ZUhteDFV?=
 =?utf-8?B?NEo0cE02blBlNllNQzk0WTArV3ZwSEV1YVdGZWJzLzhFQmFrV3YzdXRsaHpH?=
 =?utf-8?B?dURwZjJuZXNDZGJMZ3RuUjE4M2VpZTNnandOM1Y4bjlmaDhHVHRVRHl2b01P?=
 =?utf-8?B?K3k4TG1GTm1VbzlycmpHU0NsM01qMWpPMVRlOSt1cVRGUCt6NGJzSWFiUUQv?=
 =?utf-8?B?TDFNb0Rja1ljTGQzaFhxaUN4THdZNWdObE5sNXZ4dnQ0RjJDYXBBU3hTUUhS?=
 =?utf-8?B?TlV6cXJvOVZRdUxsbmVHdFhXMnYvY1g4NjlpQnFkQWFpNzJ6WFlqdktEeHht?=
 =?utf-8?B?RW9odDRyRWJaZ1NVVkRXN0IxSG9STXZ6eEV0T0c4VURvRTF6U0MyWjNyR3Ix?=
 =?utf-8?B?N0dkTVNyVjdLUkh3Sy8rMVdnV1BTZ0NFZWwrdVJnS1daRCtUSWdFM3psSFk5?=
 =?utf-8?B?R1lSZlZqQmFzSUY1VERvbHVxNGpvMjN6SnlhZjhlMHBBNklxa0ZIeGNHWGFD?=
 =?utf-8?B?KzVQaldteTk5ajRta3VFdGpIMU5DTFdoVDBSb1Qvem41Nm5yYkFuVS84L0FM?=
 =?utf-8?B?cWNqeTd4b2dMbU5PVHpyQW5OTWEzWExINGhrbEtvUVByaEhlTFZxbGV6SXV3?=
 =?utf-8?B?SXN1c2plN01EMGg1cUtlZUJiaUpjRDhlZ0lDVFplRkJRQURNbk9vcmRoM2dU?=
 =?utf-8?B?cHdHQ3h3eU1lcEdVamU0NlY2ZFFQMi9ObFFENUNzUXV5TUlnY05jbzlsZ2VR?=
 =?utf-8?B?REdHQ3N6QzkzYjNpWWF5emtvM045c2JZZUZFQjRXYlVyaVZvTzRDNWducDkw?=
 =?utf-8?Q?M/8FYyzV3uaFT62ITxU6R+3NcHSccERrlAPs4ud?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b08raTRlaThMV3hvc2RkVm5FR0grcE4rd05uSWF4WWNKbXhVODd4YjAwMmFk?=
 =?utf-8?B?QUhIaEdsZmNKNFg3dzZ5WllUYUJKTURsd2R1bldXL3Q4QUFUeXBCRlluMlRJ?=
 =?utf-8?B?UytlTlgxU0F3anJ0Z1RIL0dxbTRLdmlIcHE3Tm05SkJXclpscEE0WnMvNlp3?=
 =?utf-8?B?Y3ZuLy9SR3RCM3dEcXROYnQ2RlZhcFA0dmtxaUNRNCtTWWdETUI2YjRyS2Rm?=
 =?utf-8?B?R1Z0YXgveUZyRGV1b1AyR1kvOGtNMW9jWVFTRzBFdllZOVNWdjQ3U1JLUFFa?=
 =?utf-8?B?UUdNTWJNN1MwZUJoaXFrQWZsQkNrRDgxcnZYM1JkOFFqS2hXSzNGaUoyVktz?=
 =?utf-8?B?VkpaVXlSVlhSeThaUCtMcG9USmFEZXlDdldjaTJIbVFpQWFIMEo2Lys5elVV?=
 =?utf-8?B?OVowNTZpalpnbEF1dksrdEtvOUM5QTNTM3E5YXNCUXpvVW81YjVKMGhDVGd3?=
 =?utf-8?B?QVhBa2ljdnlRaW91TUxMZ3RoNmRUcEx6bGxGclA3UEduVHhoV0VpOVN5V3Bw?=
 =?utf-8?B?WXk2WnBTeGd2eTRWSG1tZGZoS0s2SkNvYXFabTJ3ZGtSS1o4dkd3VTBYcXUr?=
 =?utf-8?B?YmRESnJ2S0UxS1BTL3lvN2JxVFpvVTM2RVl5VUdOVHltRlNHYWsyRndTODl0?=
 =?utf-8?B?WkMvR1lLZ016K1JJTVU2cXhRSnhVakRMMHEvZzdheTFLTkJIdC9lR0R2eTBp?=
 =?utf-8?B?UDVlQzZ5enVlMjIwdG9QN05KbkQ1Kzl4WWVSOWl3QVFWcHdyNm95eUs5bjl1?=
 =?utf-8?B?TFBUVzdQeDFDUVZKZkkvRzhTajhuWDI3QXk0MHFXSDk5YUtWM2N5dzNOdndq?=
 =?utf-8?B?eTdNZUNSaVhIZnhZYTNGMG84VDZYVlV0c0RwK3FDN2JlTWZvZ0VJZ2ZoelZF?=
 =?utf-8?B?VTEzdkU5OVBjZ1d5Y2YxSUtadTl0Q3dNald4QUpSZDBTZGVaanRhTjZKWFl1?=
 =?utf-8?B?MTA0Q3ZpWi9pR1NjWDh1WHIzZ1ZOZW9LYkM2QXB1aGhLYzJ0WXFHdHprYVcr?=
 =?utf-8?B?QkRLL0dNTWFjTjVWT3JXTlFxbjcveWFkbGlyZlJMZmMxaW1YVjVxMWdPVU44?=
 =?utf-8?B?TzdDQjA1bGRVUnJadUZzK29Pajd1ZEtVelBHbzVtTm1nZVFjMjJmTUxiSlhN?=
 =?utf-8?B?VXJ1Q3ROZE11eVJrajlSQXBRSmV5RjFmVGVWdnVscVRGY3ZGOG42SWlaOXlv?=
 =?utf-8?B?ZVZNUHRFK2pZTHlGUHFaRHFLWkVpb3gvU3Z4eXg3TlZhTnV2bVpBbG9pWGs4?=
 =?utf-8?B?a0QzZUtTbkpaTWR3YTFKR05ZcHBSWlpFSkFkNDRrMHplYjdjMGQ4bFl0SEdD?=
 =?utf-8?B?WUxtU0tEaG5VVGdoYWFqczVZMExjM21FeDZmSk54QnJQWnpJRnpLU3E1aEtI?=
 =?utf-8?B?ZHR2Sm5rc1FhUi9Hc2RkeUhjTlVFc1ZCQXRWdXM1ZjY1NlMvQU1GWmVtWlRD?=
 =?utf-8?B?d0JSRUpHNFh1UENDSGJNTUk4SGt1KzBwME5UWFU3R1hNWkNpVnYrUWoxaHhl?=
 =?utf-8?B?VE5YTlZvWG9QcU5JaXEzUXEzYlVJd09SeXhKOGlqdzNRZWc0clQrL2N2amFJ?=
 =?utf-8?B?dEhmc1p3TGRZZElyUE5TT3l5c1dOQUlsbEdOZmlyYUdxc1MwNzF6aUhITVBR?=
 =?utf-8?B?ak9EbVNDczMrc0JHVTY2cWtQUVdrRjJWTUxla0lKSFIvRFBRTm5nSlJXQmJr?=
 =?utf-8?B?bkdMZVEvZXZNbTRBeWQrV0c2ajE3cmxkbVRuYUZOWGlMbmhmeTNPQ3pxakRw?=
 =?utf-8?B?TC9aSHY0MHNkYUdRMW5uUXpuYWQ0ZEpxK0p1bnJEdkpISG16OUZNM0pDY2FJ?=
 =?utf-8?B?KzBvL1J3QmhlL3FFOGtmNTQvQThrS1NyQ1BPYjNEMU1ReXFweFNZOFBVcVMv?=
 =?utf-8?B?OE9Gd3JaTlFkMGN3ZmlZRjh5dGRGVGhCNko2dlp6cDFoM2pvSDVtb29IS1dJ?=
 =?utf-8?B?YWFuMFJHNWU3RmNBWlYzUWFYZ0V1cnZDZTlpREZjcy9aeU9rd1IzSXhPNDMx?=
 =?utf-8?B?aFZiOExLQ2piTHFUZFl0aWcrQXpTeDdSUm5URmEvZzN3ckV2YUxaVHBCTDhn?=
 =?utf-8?B?L3pxQWxZVlJIaENJb3NpenBsN29vVHMrMHlrcDNKQzhUSUtZYnU3YXJzc2FF?=
 =?utf-8?B?K2QwelJkTytKTisxTHRraFNsRE1NRE5NUVRoOEc5ODA3elF0aU95SkR3TEor?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RfI13UwGGfDQF/qN7Svys8l+dai6wYcYghRdnRyWP/5J3xCKfWkT9OKlEnf1e/EF8rloox4MgS8+i5pa7M1eR+nSst7VuFHeBrDC90dossvF7CJ4ZLgH+UfZ0K2wsMgx/9XIMfc50JygaRF6ujCGIQRhC88pmtqkixGn9TYeNvZYSFwQHez1U+ixMnmwxMR01eFTL4S7k8c50kpyjZ7mVpVj5ZpHm3EYAipJX3Raa4RxkSraRIbbur33/OToTvvZCGRGyCvgHnn5Z+HSd/snD5IU+kYOIUP6tXJyMs4ITvxILJlWhx/gHy+aZv74wMWLzjhv/M9S6CBSigbHmmYJZYoGB0kQdtzcvzz/Lh3hjscBX0XZx80E8gXL+B/sdqQU40RV7gYApt9nAhhW8UecrJ/8+A8Vctyx7dsaIMcObU8ah/a7WBqH46atDkRpIZTuiQNDzFqIvjelhi/uYDcsvft0F6BptHZ7fCGtusxcnUx4ucgc0DogzWKXgvGwEThVgwtGIf4D4z9xcMuITtjuDCrlOAWzuR+fT4+R1v7m0EFGtonX3Z+yGkEXY3p9yPMfRUpNxNmrfVIpt5kAFo1G+Js4cV1t+uPdFZSU5iE5lIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e60858-4d2a-4eb1-43c4-08dc84baeb7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:22:33.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dopZIj3bdSDxzWm6D+wnCzBRLlRBkbl3Xd1GAHfoFD552Tbj6yJQu95jz8jm+9SX0tCg+ot/w+c9dJk5VEk8Q6dCHxK7r0pQ+F8Wyg9C8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040139
X-Proofpoint-GUID: b-t_FbAEFC7sCUrQFG9xoBAaeuv4tfkp
X-Proofpoint-ORIG-GUID: b-t_FbAEFC7sCUrQFG9xoBAaeuv4tfkp

On 5/31/24 4:09 AM, Ard Biesheuvel wrote:
> On Fri, 31 May 2024 at 03:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> This support allows the DRTM launch to be initiated after an EFI stub
>> launch of the Linux kernel is done. This is accomplished by providing
>> a handler to jump to when a Secure Launch is in progress. This has to be
>> called after the EFI stub does Exit Boot Services.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Just some minor remarks below. The overall approach in this patch
> looks fine now.
> 
> 
>> ---
>>   drivers/firmware/efi/libstub/x86-stub.c | 98 +++++++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index d5a8182cf2e1..a1143d006202 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -9,6 +9,8 @@
>>   #include <linux/efi.h>
>>   #include <linux/pci.h>
>>   #include <linux/stddef.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>>
>>   #include <asm/efi.h>
>>   #include <asm/e820/types.h>
>> @@ -830,6 +832,97 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>>          return efi_adjust_memory_range_protection(addr, kernel_text_size);
>>   }
>>
>> +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
> 
> IS_ENABLED() is mostly used for C conditionals not CPP ones.
> 
> It would be nice if this #if could be dropped, and replaced with ... (see below)
> 
> 
>> +static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>> +                                                struct boot_params *boot_params)
>> +{
>> +       struct slr_entry_intel_info *txt_info;
>> +       struct slr_entry_policy *policy;
>> +       struct txt_os_mle_data *os_mle;
>> +       bool updated = false;
>> +       int i;
>> +
>> +       txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>> +       if (!txt_info)
>> +               return false;
>> +
>> +       os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
>> +       if (!os_mle)
>> +               return false;
>> +
>> +       os_mle->boot_params_addr = (u32)(u64)boot_params;
>> +
> 
> Why is this safe?

The size of the boot_params_addr is a holdover from the legacy boot 
world when boot params were always loaded at a low address. We will 
increase the size of the field.

> 
>> +       policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>> +       if (!policy)
>> +               return false;
>> +
>> +       for (i = 0; i < policy->nr_entries; i++) {
>> +               if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
>> +                       policy->policy_entries[i].entity = (u64)boot_params;
>> +                       updated = true;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       /*
>> +        * If this is a PE entry into EFI stub the mocked up boot params will
>> +        * be missing some of the setup header data needed for the second stage
>> +        * of the Secure Launch boot.
>> +        */
>> +       if (image) {
>> +               struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base + 0x1f1);
> 
> Could we use something other than a bare 0x1f1 constant here? struct
> boot_params has a struct setup_header at the correct offset, so with
> some casting of offsetof() use, we can make this look a lot more self
> explanatory.

Yes we can do this.

> 
> 
>> +               u64 cmdline_ptr, hi_val;
>> +
>> +               boot_params->hdr.setup_sects = hdr->setup_sects;
>> +               boot_params->hdr.syssize = hdr->syssize;
>> +               boot_params->hdr.version = hdr->version;
>> +               boot_params->hdr.loadflags = hdr->loadflags;
>> +               boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
>> +               boot_params->hdr.min_alignment = hdr->min_alignment;
>> +               boot_params->hdr.xloadflags = hdr->xloadflags;
>> +               boot_params->hdr.init_size = hdr->init_size;
>> +               boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
>> +               hi_val = boot_params->ext_cmd_line_ptr;
> 
> We have efi_set_u64_split() for this.

Ok I will use that then.

> 
>> +               cmdline_ptr = boot_params->hdr.cmd_line_ptr | hi_val << 32;
>> +               boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);;
>> +       }
>> +
>> +       return updated;
>> +}
>> +
>> +static void efi_secure_launch(struct boot_params *boot_params)
>> +{
>> +       struct slr_entry_dl_info *dlinfo;
>> +       efi_guid_t guid = SLR_TABLE_GUID;
>> +       dl_handler_func handler_callback;
>> +       struct slr_table *slrt;
>> +
> 
> ... a C conditional here, e.g.,
> 
> if (!IS_ENABLED(CONFIG_SECURE_LAUNCH))
>      return;
> 
> The difference is that all the code will get compile test coverage
> every time, instead of only in configs that enable
> CONFIG_SECURE_LAUNCH.
> 
> This significantly reduces the risk that your stuff will get broken
> inadvertently.

Understood, I will address these as you suggest.

> 
>> +       /*
>> +        * The presence of this table indicated a Secure Launch
>> +        * is being requested.
>> +        */
>> +       slrt = (struct slr_table *)get_efi_config_table(guid);
>> +       if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>> +               return;
>> +
>> +       /*
>> +        * Since the EFI stub library creates its own boot_params on entry, the
>> +        * SLRT and TXT heap have to be updated with this version.
>> +        */
>> +       if (!efi_secure_launch_update_boot_params(slrt, boot_params))
>> +               return;
>> +
>> +       /* Jump through DL stub to initiate Secure Launch */
>> +       dlinfo = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>> +
>> +       handler_callback = (dl_handler_func)dlinfo->dl_handler;
>> +
>> +       handler_callback(&dlinfo->bl_context);
>> +
>> +       unreachable();
>> +}
>> +#endif
>> +
>>   static void __noreturn enter_kernel(unsigned long kernel_addr,
>>                                      struct boot_params *boot_params)
>>   {
>> @@ -957,6 +1050,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>>                  goto fail;
>>          }
>>
>> +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
> 
> ... and drop this #if as well.

Yes.

Thanks
Ross

> 
>> +       /* If a Secure Launch is in progress, this never returns */
>> +       efi_secure_launch(boot_params);
>> +#endif
>> +
>>          /*
>>           * Call the SEV init code while still running with the firmware's
>>           * GDT/IDT, so #VC exceptions will be handled by EFI.
>> --
>> 2.39.3
>>


