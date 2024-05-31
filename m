Return-Path: <linux-efi+bounces-1087-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C68D5714
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7821C215C3
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 00:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B17613D;
	Fri, 31 May 2024 00:41:42 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5A4405;
	Fri, 31 May 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717116102; cv=fail; b=mVzIQ+T6jNkaSFQrb/JfnrWtMR463q//IYEXdF5JsLUUiutLgNEH/VIXGxiFhe3w/boyWwmdxemBBrnd18DKuW5ukVBRgCWl02t0pXXY/uYOcxNljzdMTs58kxDZls4zoGiRw4T4YZgFHarRyy6qhkTn0ZhdndphaaSs71PPLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717116102; c=relaxed/simple;
	bh=GF4vGSeapOvgFn2kVLd2qCpV4w1dLINDA4qw7PXRRhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6jgq0ZKfZlY9HXz/B6ChgRc5NFA4gT6IHTOD8p1D2LS0MUJpfUQPCX822G0ZWHN682wYzna1BdnGoiV9A1mJStJ5dFSBYSrlkFlHam0U9n6/L+Q6mN130oq8BgGnV5VGhdy0XY5P/21YBrjaJEd3uvElTD1aPymqyXvMbBUtfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UEffSQ005706;
	Fri, 31 May 2024 00:40:01 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Ddxiaq3H3Fq3NhFKy9H6ozROysNx/PpOwBwQ5YeQurPY=3D;_b?=
 =?UTF-8?Q?=3DLn5/0ITy07SmGV9kFPyAzk1jNuYheS5dhjOXtAPVtPl+aTcQx0jrHlZxr4Cv?=
 =?UTF-8?Q?HRgfCpN2_pPiLd8SBuvAGyvAH6+ujCVtK5r4yeY3GUYtpo59UDyGpUnOP699FxP?=
 =?UTF-8?Q?Kp6vzZHpbnybrf_2C8FRwU1tFKU1CjThG8AhVMaS/DbQr4r0ueuy5Pj+GIHqEYn?=
 =?UTF-8?Q?GSxP/Vzg4jhxUmLlYsLj_THi8a2JtPyePox+etwUFZw3jXDIevIBcX/0gEF5R3I?=
 =?UTF-8?Q?gOAufNxOUk9cprGylzRxs6/Fzu_I0FYiwukwQpfsZJTU1Vge7BZXTnlJVe9IJbN?=
 =?UTF-8?Q?QLda0uJGDq2XQ8jkHLh9UZk0JNMVtVaW_9w=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4a61m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UMfwEq026627;
	Fri, 31 May 2024 00:40:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5098hkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzmXIxQ8OVmGBgP8hb3iA431xaY7Dq2EpxsRw41K0IKmMt7myO2xESmq+yKOr9ginjShqT/gvfaXoaZBAPRKrxr5L7iKvIkuqyIx53sfwHssKsoW0nMZWNyU5z7u1a8ip2M5ILRh2A+PqpBBvOGkbTQj2lO/TtEoyLpNKZqo7nyM5dDutE1UeXbVSPzMJGWXyqFN1wRJs7eWlp+nmlA5t4WQg1PBqK4VvXZJNwNOoGRCBGO+yJY6WH/SJDeKgQWfytBIPuJ573R4Co/3dmfnH3VJtGR+XP2APy5XwZiGEbMMP2T3/u32NajKonm0Ta3mbxI75x+MXkUHgujNJufWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxiaq3H3Fq3NhFKy9H6ozROysNx/PpOwBwQ5YeQurPY=;
 b=GU+1bE6FBnCHQ+yUfKq144YfA9fkgd27RCZGYrR/HSo5KztvF3yvH81TGIPhCxtS7TCdCs1s0/EL8rTGPovDY74Wm+zu1br6UAkmQfwrfTezozs8+6aAJGWIrO4AOQI6XUe1Hl5ueLe1P9CZ1Rmwj6TmBynsZTOiac8oJ2D7/oRk27lpWryXXX4Jqf3PHRvBu2PkmZpf9JV+en1Hajcpw19FZgfVIfo1dlT4waxzGhUCHfV1DASfereraHHq9yqo448CTMogDTujW3Jw3stqHZ/kj/fhvFF61VeDnWUqPVtUTprY8NRzyYnNnqvHo+MosOZ6XZGJeQ4Aj0Jc0apKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxiaq3H3Fq3NhFKy9H6ozROysNx/PpOwBwQ5YeQurPY=;
 b=omZQVmE5xmH3ASOBl/ECOJd3/BMl2fP4TcW9ZJ8gtLQmKR6jZkMCAejxcAmN7a3oIapZoJH85jxtmubAyvFJMfLzP0dsMfurVVd8XtE286llu7e6XwP4vWlUcP8gQSlNk8P33sE1piznzbt1M8yPzf5hWXTxPIKpCzTDEuWu9OA=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 00:39:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::5527:ab55:d1e7:9c9a%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 00:39:55 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [RFC PATCH v2 1/8] certs: Introduce ability to link to a system key
Date: Thu, 30 May 2024 18:39:38 -0600
Message-ID: <20240531003945.44594-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531003945.44594-1-eric.snowberg@oracle.com>
References: <20240531003945.44594-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ef8dc0-a1a9-47dc-dfff-08dc810a30f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Uc5WXE1wv8rhS0TIgA7ykZ15a3/xAxt2HQHTRirgPMeKmy1bMAyt9ezIRxG2?=
 =?us-ascii?Q?BdX1szKWOU5BqvUwDXpdR2r/3JgLp4uva7tvO/jV4xkL5TEYZ4GK7ILQjRab?=
 =?us-ascii?Q?Z3aCqJZux4IW8k2gYOqJ3p6/D61PPuSd0MCqj6lziWH7LCJRHrTDpi/mZDy+?=
 =?us-ascii?Q?uwiXr2+fSsgwSNs6Adx74+Ij66DQZ+VY1uv2DlwQvIvsgchtyyvHBPIeoFeC?=
 =?us-ascii?Q?8yfkHNP5nTD1IhsImo0o7v5OdeRjrHN8axKrw9hH1ic3EpZpdvi9GZFmyM9W?=
 =?us-ascii?Q?GecaZxvB0slkXQtuIlhpfaDYsVJOr8TeoAjIzyeauG9yVTscb0CKGusuIJop?=
 =?us-ascii?Q?qtWxsMdNtlZd0QJhDx7R9hjg2W/bSJRnF5ft4obhEBUufGfQpGszo1/AqftL?=
 =?us-ascii?Q?ByPqsYME8yklEHbsD0u3G70oEy5DEmtOhp7kyGTtgfctkEpyD9BSA4y9j8VL?=
 =?us-ascii?Q?/KSZE8Oualcj8dq8JIZDNHWvDWP3Uvd5AWN17n2aire+GvRb/t4W5YxZYyqf?=
 =?us-ascii?Q?bx8mSBHnQYErgL959C6YdZZEdlfnr7Uho7Zvp63/ankSoXt7szDJTf4EzWAR?=
 =?us-ascii?Q?lOLdfk6Wg6qPkewcCfo9w3N6N8tqIAEgryVlSDGf/mnx4s/SBI38ugtEJ9e8?=
 =?us-ascii?Q?6SYx5SK7OiggdUP1puy1m8JXZzQGT9w9Q/rHSfp/ZQiFWgA30ODHIFVxwn7b?=
 =?us-ascii?Q?oK4jfFZtGIhBVRNEBQclSmriz6FBmw6kTWxnrd4SoEmN7vKC2hyp4II10PmM?=
 =?us-ascii?Q?BqMmmKXIYJ2wc6qEt291i5BJegiTBlMXouxeQaG7oEOvYD0/4zCDrmJnBOK5?=
 =?us-ascii?Q?5iHyowv/XwgE1rOd+T8lOco6aUWONDrKEYXO0dGPuc3Oghd6rTolXIMj9X62?=
 =?us-ascii?Q?vvMnAnrt5/2C1P3HTEiemluX1ShUaY2Bwk5CdDxT9NGnKnTNBWcxk38Yg5nk?=
 =?us-ascii?Q?ZvWPtYtjom1dL+ZA0qhWaDF6PcYvbLBJvhwQ1md3KF8fKofv44Y5Spo9+yZg?=
 =?us-ascii?Q?aNjihGnKfHr2LD0mp07JBPzTKten/AkZgt31YzH0A7T63CwpXQJKaqdHb5YZ?=
 =?us-ascii?Q?l7w1UkdshO7k7Uef8JOameeV5KlOoQvO+wtZnYF/xylI7BNZKE7tMnIY2vEY?=
 =?us-ascii?Q?p6F/70iezjeISzHUZnXVEqbQC/U9Exw2fpYpCYretch7k5Sl1jMJRPk15LJr?=
 =?us-ascii?Q?kpPG2MYXF/WCpZdXMZxo9/uFYipv932FhygbzJgqFhLyMmx12AjjZWzyDcyv?=
 =?us-ascii?Q?8kFVdSy+F9eiYTvT2B1v4x3BOv2+YDXbBUoMl8nZKA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tDM4MY9PNv7o06+CFtGovj8HPD4tQ1TmCicyLQSzYiTDQ3q4HE9DYXrbAdC8?=
 =?us-ascii?Q?SGXOBO8OZ+4ltuGI89bfPGo1y7WSXOaw2dpHK9EegfJF21JRGb3u0xwRPsQy?=
 =?us-ascii?Q?4As2oXyYIlJlIfe/Nb9rMVeEbBjKvu1JLRDzILiFL5AA7iffWoXlYFND4BIs?=
 =?us-ascii?Q?TAyNEB3h2/+EGXolGcD+cIHNvhTOp+yNy2ejzaqrFuwHg/z04s3oOa8c1CPv?=
 =?us-ascii?Q?ONlQtd/G2c4KJj4KDb+7BusTCpAAnlHWVOoxAKLF0r4aRWQTfK7RlE3A9qFg?=
 =?us-ascii?Q?Cw/CdkGVXHyICusqbQGJJiz/dH1odz+if67wxTCp0SuDovJjJyrqRcthw39N?=
 =?us-ascii?Q?0bFYV5DXKx5Pwnfl7YV8y9/if2s8nVCTjaou6UxoAmrqyrOYNFUI6E341FdQ?=
 =?us-ascii?Q?Pk1AP6yav54BBB8yvgZ8iP0tfTNOu0QyvsWNcsWIMNC2clZq7ck0NA9mJeoi?=
 =?us-ascii?Q?kF3VgCJF4XWQyUsoy2P99Uw9TLfO+TPqY1RwOe2sCcsFMBMZ9vheLSEWerHd?=
 =?us-ascii?Q?8doiCpbj7CdrMSnZma+x+/rGGYdwRMAEH15pCovqK8x0OE0IP09WCcxYWhzF?=
 =?us-ascii?Q?fhF52yk9N5j7F5S5T1OfXkoCtGSJ1nxJCI3E7p+OX7/bM65ma32YwQK273Pk?=
 =?us-ascii?Q?zc4zKYkDfM4Ins6SHH64r3NYe0eTfwIgF/IXQ7NpSw2ky0fvC3+JDSgt01ol?=
 =?us-ascii?Q?rPPwtsSxBNMn/gXxqXLZkz3Pq4PTEVM1zxZvs7DbynwkdoP66JvEDDXqeYa+?=
 =?us-ascii?Q?AIjjxPFGVDKE/6zmldKv0VYgOR2/4e4+Vogr84AZwAbDDSAg+MlSQBDVOw6O?=
 =?us-ascii?Q?CBlsqAMMJTJ16n3VOuEc9foFpE53BedY5Ers0vIOAmmIlw4tdvTq6xnZAisA?=
 =?us-ascii?Q?eE7xD2u4JUu8Y+GcYBSf1kOn7YYsIPkgm7hcxUj9QmTEkXl7750e7+WKs/hq?=
 =?us-ascii?Q?yHops/t0f3W6y41udBV9JYZGSnQj3h2WnKySE7N72tYzqO+kC7UwfMhtscGD?=
 =?us-ascii?Q?pmfraSdaivOJtRIBDuXZrSqw9V11QFZ3SXvqEU8lp024/6dRFZjv0A5JNPzl?=
 =?us-ascii?Q?Ll6eweV2pE8ZySPknNROj9MAJQRzARZ5da1rGIPEvjNstJYOyoKkVKLEDvtp?=
 =?us-ascii?Q?4dQloUBrv9YiCrxxROnCLCR8RdsoYN7lNLeAYKP/Ip1azTLB8r9uEUqLtfAj?=
 =?us-ascii?Q?kbTFfKEbQgDmKbrazffdEdxQPAzYxo8tBntwMHfja9vzEmxDFaSOfoT27Ji0?=
 =?us-ascii?Q?u+PhPDOMMdFAXaJ00SYGDU38y70jVODic/4YvmwRMLTTibhDPQW6FtQv2J1v?=
 =?us-ascii?Q?VatA3POvqVpgXrLZx3/w0ZvGJCyHXdoJfFXTF2qIZsyCg4Z5/k/M0SgY8WKu?=
 =?us-ascii?Q?9lpgjuZorO2V/QTHu/0j5H7eeOp6w73mX7Ca6I6A3R9UH2PIw1pmh9H/gqyZ?=
 =?us-ascii?Q?OCiNqIH+MyxWv4agG/kgS64skCNcqTca5wgFXS3gUzQUgHzbTd9EAeHQlef9?=
 =?us-ascii?Q?EDEifE5N53WiBQkjwf3nsh0FIU5d0Kc0MBGDB7sgiJYZadKgZZhYP+WmcLcA?=
 =?us-ascii?Q?GbDBt/CtGoEZm3x1VK1yzWh/lGePkWQCurV1yUXUVdvAxl29pgpq1H4YFPOT?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	daAoPpdVcY/6wuPdt52DSCHHSFPIqYGdVsIfzF2Tbes6ZFLzSME12wh4pohUrFsMfHDgNum/9+BX1PP2GzSzPdXi8GhjgkSCR1H61RAKyYkVih7p19Qn0mEgM6TameURT7a2OXRybchARuaJ/v25EnddoszUmO+t8mxuw2PSDUmLTQVeVf2nN3r4MjpivEAxZLz6VHo7XuLQncUKESZRRDr+i2EXjBt4lpaGFMojbZy9CApIJCrd7fwjBbyYp5PRfNMktvEnJUYP7mBzdQ8iN9Q0oGuJ6OWxZ1LO59uw+CgouNMk91imFTnbN154cYNoVl0XTv4vLh0Gm0og8jPsvk8Wzd59vlKsAI0AUxWhCXcPY10r0pMq2Zj7N28fUZZzY+EI/J2ErkaiJxfgtKEnq6n/kxg3E9Y/H+/yi6YilYxOYOC3FkrmBxNrwkHH4pCoHS4fRGMFn0EPSUdOQDpfWCxZB7M1FtHSgWA9h9Ir0hTdfD5b3YJZc2oa1+7tXwv7R6ggMT8k4KW0XZBvemZowBKw4S6/RlutFVqYdlJms1cFhpU81CpcfQIyOYIB/Tk3Z00m37hK8IeuFHYeWSzZs1E/vQm/Ko+jWOlPpx3b25o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ef8dc0-a1a9-47dc-dfff-08dc810a30f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 00:39:55.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cNwofvojJqIbdy3jSQdGes6RVFXtso5A03VBcL/dYTci3po4qkCZ4JREY9cBbe176DlFzmbvmg8Z/b2i1MDFF57vgciE803YaP92WjKXLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310002
X-Proofpoint-GUID: cZNSQUa0p7ntgEWo6e5yWTgiWunZA6_k
X-Proofpoint-ORIG-GUID: cZNSQUa0p7ntgEWo6e5yWTgiWunZA6_k

Introduce a new function to allow a keyring to link to a key contained
within one of the system keyrings (builtin, secondary, or platform).
Depending on how the kernel is built, if the machine keyring is
available, it will be checked as well, since it is linked to the secondary
keyring. If the asymmetric key id matches a key within one of these
system keyrings, the matching key is linked into the passed in
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c        | 31 +++++++++++++++++++++++++++++++
 include/keys/system_keyring.h |  7 ++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..94e47b6b3333 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -426,3 +426,34 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+/**
+ * system_key_link - Link to a system key
+ * @keyring: The keyring to link into
+ * @id: The asymmetric key id to look for in the system keyring
+ */
+int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
+{
+	struct key *system_keyring;
+	struct key *key;
+
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+	system_keyring = secondary_trusted_keys;
+#else
+	system_keyring = builtin_trusted_keys;
+#endif
+
+	key = find_asymmetric_key(system_keyring, id, NULL, NULL, false);
+	if (!IS_ERR(key))
+		goto found;
+
+	key = find_asymmetric_key(platform_trusted_keys, id, NULL, NULL, false);
+	if (!IS_ERR(key))
+		goto found;
+
+	return -ENOKEY;
+
+found:
+	key_link(keyring, key);
+	return 0;
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 8365adf842ef..b47ac8e2001a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -9,6 +9,7 @@
 #define _KEYS_SYSTEM_KEYRING_H
 
 #include <linux/key.h>
+struct asymmetric_key_id;
 
 enum blacklist_hash_type {
 	/* TBSCertificate hash */
@@ -28,7 +29,7 @@ int restrict_link_by_digsig_builtin(struct key *dest_keyring,
 				    const union key_payload *payload,
 				    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
-
+extern int system_key_link(struct key *keyring, struct asymmetric_key_id *id);
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
 #define restrict_link_by_digsig_builtin restrict_link_reject
@@ -38,6 +39,10 @@ static inline __init int load_module_cert(struct key *keyring)
 	return 0;
 }
 
+static inline int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
-- 
2.43.0


