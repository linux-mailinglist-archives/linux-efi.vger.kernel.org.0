Return-Path: <linux-efi+bounces-806-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8650878A19
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 22:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD9C281213
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516A56B95;
	Mon, 11 Mar 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpOZAGDJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MaqxcSeJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A043AAB;
	Mon, 11 Mar 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192729; cv=fail; b=NF8Fq6e3qshTMeBK3lYtrZQ7IUH/Of5f5YQ9aAQEzPx5zB02M5iQgCBhaAIsQCAX2/UdUPqlzixP3mEMW5BXvzZFd+mK0x+P/0JzDpA6cihIVXiQ672+gKdDmnxR4JwBxgs5NcT4PMaYDF7PQtLZi8r/0/bmJsykaW6FoVXGruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192729; c=relaxed/simple;
	bh=T9LXE2n+5lDlAOfMAt7BWFH9QpW22SinIDGmp1DeejM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aelTKmoz3KUIjb3myUAx6el2O3wlXLXrKJm/slw3L06PkGLe/lZ97X2Hf22HRiQ7g8LvCQGHkLID/ybp0PhfYWwm/F03bDY7/RYJ4VQxXM6ZrvbHpT1VMjoifvXi6wgFxv3HQgjGbSmTIoJM/CRViclC9NnmglVtu5M6UE2JOls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HpOZAGDJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MaqxcSeJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BLEqfj013092;
	Mon, 11 Mar 2024 21:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=T9LXE2n+5lDlAOfMAt7BWFH9QpW22SinIDGmp1DeejM=;
 b=HpOZAGDJJltwCjn+L+FL4AiWdW+K58h+No9IaWH+pk+M2Se9Y5eEg8j7fZg+Q7O2a6Xp
 5pBsHH+IrJV9Drav/Rf1W2y4FbY+5KpHHsafki8ppqhn5dL/5z6JJA2M0IW/m5rzP3rv
 FVVyiM9y2pbe57arr2iui4pr5MquyTDA2OrIZrNlU2nHopkuOU3dv9FK3GiIokn3O5sC
 0afFa59RTL52zlz7L4pp54eX1OKM5U3u5H0W2CXjNCzWFhXLjpIIc2iVlhCGzArKsZAl
 M6ncuwIEHIO4nH1Wt1rS2HFkvdrxMzrzlke8hCaT0YpH6upjnqWP8wCES0TPOTaZ05t4 KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbm8mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 21:31:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BLKIhu033723;
	Mon, 11 Mar 2024 21:31:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre763ka3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 21:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwwizsPWzQKLJTUMTLfxSyBbESvUgvXT9rDODiqc0wnwClvL/WnQQakp7/pTik4lGByb3TN/NIb3PadfYktnXgJPa8oAbO75HprozHdDGo9Xc91U7KuCog9kjsqlaXh391/Lz/COZH/HeY7ebPvWwfsHXx0UbyeulZ338HahWk3wiWYLgGKlN/yVKJzKDuhMvXn3xopR/oEhGSJzOSN/MgbLrOvP/9cgn38eGbNgGPMhnpAZUCKjWjmnfroR1/JTrdRPRwtsP7iGaB9sO96l5bf4K2EYazQ/JBvuMy72aoujnjQuNDLsZtbi5V1rBnS4dDT3cg7ep51XVEKCr9i5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9LXE2n+5lDlAOfMAt7BWFH9QpW22SinIDGmp1DeejM=;
 b=lCtWDnAca3JwBnHhn/2l8gjcgfbNp75knkiMzgS9oRAtlCU6gIaoa0JGDWWsvkkZbuxAAxfKuLanXDBEIsKXZfiy6WY6jrWPom/QK1AgkntWgsD8NQn1cxOQSoXiHLTxRCqglCHzN+hYz6BQWvO788Fh4bZq8TUcumG3hGzqc3Hmt4gcwG8sRZddscBNikSXtTLuZM61ls9E2bpRgLqOoR2LMr1LA6OOODyvhZHb2QzmrHMicQrteQoTsjox91VleFEzBJTyFWQ2GNbDMz/dP87001p3xJjMJ5QXDpWhY8bpCFuM2Tu+N+fz19sbSULJfph1krp2w4NRmg1ycAofkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9LXE2n+5lDlAOfMAt7BWFH9QpW22SinIDGmp1DeejM=;
 b=MaqxcSeJ5VBBeR9g6UkCbrXG2GA3VT2yAUH1RYnkW6//0d/GmsKSjc3g/YebkeMrp80XXV0tYdbAC0Ytkx64UwshLLjTWyP6McO59rLHg1KzPfh4glC5UcdfnDHYfmusG+ofFu7LSrKPG9EPNeIhaE8+SRQzaq7C67CwxRkvK5g=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:31:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:31:40 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
CC: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ard Biesheuvel
	<ardb@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "stefanb@linux.ibm.com" <stefanb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Thread-Topic: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Thread-Index: AQHac8/Wy3kR1DBbWUSwLVt/DZ3pl7Ey6kGAgAAlFQA=
Date: Mon, 11 Mar 2024 21:31:40 +0000
Message-ID: <77AE4DEA-9474-44A1-88DC-852523C36797@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
 <CZR5W1VPAVJC.2VZOSD53YNT9I@kernel.org>
In-Reply-To: <CZR5W1VPAVJC.2VZOSD53YNT9I@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS0PR10MB6799:EE_
x-ms-office365-filtering-correlation-id: d1e7f02f-efa4-4762-08cf-08dc4212a40e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jiNstXHj4dyuQKkqYzpQYCpUUYsaxR1tP29EHTYwcl+pPVvSlgSahAXjty1rEVf4Q1lmzPxabsYUY+q/biJfvzsCl6LXpsOxf85SKR2UiwE9XtTENafwqBkdnexXDJCBr6vZFbqDiC7mcc+RuHHHPoIRKdWa2Q+A5Y7OI9llliY5XmCAPPJiaAO3NSjx+JTXOrPAlh2/SZ5Of7HOHFcjMc1be8ekv+dwaVCbrfjgZOrWWGvWg0OBxewtrEeiB7zG5BX+4t9lpToG0XxHtTDdHxnDYX2MiI9qCOy8FKoo623NTC5MAKKrdIs1mfSTEu8jxoF4X9FRuyJtxGQhU4PBCN1vdhen1VcrBrJ10lupB/zsUpNhjwbvhn2TSouNPN7fuNDPEZ5RQkK4E/ryELecY7MacQCNs/Q2KSXZlY13pN5HcgXEroyTXUvplC0982xB1GCzEGmHkv/lTRLeFQGbVef+NlDDz9hd8toSQGNuqL1md72yrkYX9vYU2WyenIuZv0DJMCuuq9hf8s2GecfrwAyx27Oyo4ZkQu1FKo1smlqcIZfMmwO2K/ipGpflLQhlpLaQyKkKSC0jTKOwdSnQk75TF9JCVDWuob7wWc/LqnfzSDJIHCCDT0NFjRWyuG0agNNX/HP8XtfHnNPvKzh3lh9Ac4lOGU0S/N8qTnHGuj+g6iRz6cjM/OSbv4cdL53L7zB1ntbjToMTb8bZKRwE2F4cMpOTJqd4OtRP0fasv04=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bS96eVF5WHcrall0ZDhtaFZ5VW1YM2tjRE9wcVludFIva25PV1laVzFkcjVH?=
 =?utf-8?B?SHF4Z2FoVFMwaloreGFOaUpKOUpId0RKOWtBM25wNzRjdlJPTmx2Z29uS0Qv?=
 =?utf-8?B?bGwzMXMzY3NmZkc4S09zQkQ0NEdNNjVtdzIwWTlFZk9OYmhCY2VoRnBoa1RE?=
 =?utf-8?B?cGNwSGhWTnY1b1dpRTlnT3g5dCtDWG5KRC9aUVpYQVRNWDduclpTRGZjYXAw?=
 =?utf-8?B?OEZPZHhDZFJncERUblhkWXBoS0I3MTdpOTAxdFlzQWp6cDhUU0NVZXJ5NHJD?=
 =?utf-8?B?a2xnQk50bmloaExpWHMwQXJDcWl1eTNOdFcrZ1UvZDg5OFJkUmFOMTNuNFdL?=
 =?utf-8?B?SFdOSUUySzd1dVFyS3AvNzcra01UNlhEb0ROYWM4WFRxTWZYVVpZQ21oSnpJ?=
 =?utf-8?B?WjhESldCL3RnVnFwRFhhaVNQVi8zTldJMXhsajFwOFUvTHEvL0pxS2xwVVBN?=
 =?utf-8?B?eFBObDVSb0M1RTF6eGNxdGxFZHBhMDJVbnEyQVRaT29aSUZqVlpzQ1RWNkdi?=
 =?utf-8?B?cWJQUTR6aVZYd0NCYWVWZ1I1RUU2c1k3MjdaRFZNUEZZZkFVaFdnTHp6OUJX?=
 =?utf-8?B?MjdVOExkNnFRc3Z0eEYyQ2Z2dHM3NXladjVqdmtrWG1rWGRjTC9RdHFCTVMx?=
 =?utf-8?B?d05xV3FOYXdHeERVazdlKzN0aUR6YXBZbCt6cWhYWHNjUlBGVUFkRjIyTGJ0?=
 =?utf-8?B?Q3h6OEl1bHFCM0RGb3NQeG9VU01TZ1VVbTV3K2txU1ppNlpxOFc4YXp2ZzFp?=
 =?utf-8?B?T1U3QWxGL1M1Mi8xUTZBdGZQZDRoOWhaNnE1bmtWb05iVERHMUU0Ukxnd3pK?=
 =?utf-8?B?V0o0djNiM0wxUXhKc1ltRTVhNDIwR2M2ODNqNmlpcHZ5U0NtcFBIM1NocC9p?=
 =?utf-8?B?TVd1ODNZcTVTY0g0eWZYNUtERk94VDR1WGZWVndGNGh1ZUh2VmpNUmk3ZWgw?=
 =?utf-8?B?dTdYOTBQQS9UYU9Ld1lFZjhVUVlqSnF1aGF2YUladzlFaU93cnhiNHBWZkpy?=
 =?utf-8?B?TlRlamxMSnl3R0xqTzFwNForcjlLdVA0QnV3WEFjTjBTZlE1VjhwYm9TeTF4?=
 =?utf-8?B?VkZCMHo5aC85dVFsYTZCZVlmTlhkb2lObEtxVnRybTEzREhDZUtSUjNMSmd2?=
 =?utf-8?B?MmQ3VU1kQ1V4SVFwb3dPVng3MGw3TkJ5UVQzck9zc091RkU0WmtGOHJsZVBU?=
 =?utf-8?B?KzlCOXNRQlp0OEdsUzI0RHE1OVJNdFRwUW1qekU2UFRtdWl0VlFmWHl5YVI4?=
 =?utf-8?B?d1M2aWtVcUlUMFlSamlXdnlXai9KVWZGUmFkeWZZeUdjeGIzUkswdXBjanNX?=
 =?utf-8?B?SW5XWUROT3pNV1ZpK2xzZmdkMmppUEZwQW9JTVI4Ukg2Y3RNVCtZY3ZaM2J0?=
 =?utf-8?B?blpDOUYxV1JYNlZvUm96OG9oc3BVWkppdUJEcGtkaEhiT2pFbDZDaTU0MVF3?=
 =?utf-8?B?UXZoQ2ZjVklSTW1IejZxU3FVRHhBcC9VVzlPNEMveGJMdm03TEl4TGpaNWJI?=
 =?utf-8?B?K3RsYjZQWGEzZ0ZJbmdSRUY2SXI5cFZVTEc3YlowZkw1OUM0Z0I1LzlIcEs1?=
 =?utf-8?B?dHpTaVFuQkJ6L2RDc3JLRzZlWFMweWcyaGZFQUljQ1kxbkdoZ2txaTZLcGNw?=
 =?utf-8?B?YzErOEdHTkUwZFhITmh6UnBreEYxYkdCSi80K0dDS0MyOHowblZEVGkwS2JZ?=
 =?utf-8?B?UzZ0aE9SSFR0c2lPNFlsRFp0MUU2SDIxNUorTHhZUlFKN1pPMXBnMmtETU9Y?=
 =?utf-8?B?V0JNVmU3cHI4bjZxOXdZbTJmN1V5SnJHYTJ6a1lvdytqZVIxQWpzeWsvTXlz?=
 =?utf-8?B?WHYrVDlrVSt0WVpZN1RyTjV0YjNobGlydlJqM1hzVXA1MlQwK2lTV3VtT25H?=
 =?utf-8?B?U29td3pwbllHWDF0VDNvcVdwZjFvSWVGQlVib214MmtDelNWVmp6Nk1WN3dP?=
 =?utf-8?B?L3dza2pQMzFmS29VWXZGS0xKdlBkd1RGQ2QwWTU4OWxiMGoyME83aFBrdmlS?=
 =?utf-8?B?aTlhRjFsZ2U5WUtacHBLY0svaFZuSGVkYzYvNUNGVUVSYXU0UmxOZTRhVFlk?=
 =?utf-8?B?anp6cWNsRGZSWjhGUnpBYzVUN3hScE1jUTErNFpDMGh4aGtIaWI4SSt6aFhn?=
 =?utf-8?B?ZS9nTVNKTzVLdVJwRGdVQ2FhMmhJbmFMVm5Yc3NndEYyNndMVG0rTkNuSUhq?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7613413F89D4034E9B306B755E619592@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nMq98xchG6QCVcqsbZqU9J4RRjJ8k/2U989bNNYvr5cJ8AostBccBZVEWc7TRK6H9S5o6czjyNa3ilAspCOOFjL9iAOGTlwp4okvui9HnoezVNDz0ZITjIDGGxrhaL6U68JafuWLL/nU8dsVEDfG6lhgeOoTyXMjl2fAit+qMJjvj5hKU5pLHPUDUkp3bhMbBs62dighDtrk8SRcw06gz3NfpxoaywpMeueoQqV307p7/7DBkwG6Wxo3WsMDX/9uY/llGVqM3trOjTd4Y+/wNLG+NwNrzYWZteFfQtL/TV1dlj/3yJplMwejkSbB6kGSrp5GelFdjglDDGNoBXdpbAXbA2PuPZvlUKGaa93VLFScRsPtqNB8aBQfugzwi8P6oARQODyB1hroqI8u26vnsLiKsvzTiMkyTbYJPSXPAJFZlC2V3zmVE/2q3uNKBCRnw07gmVuUNNnyjk9FWB1gmP/1OW4fcH2SVd7y8AvyqoClnQx6XdzOfigYYV+WM6igv5I0FLEq4DnDQTsRYP8ANGg7KueEGMlmf7gb2nzK9an4sT8cW1ubmovtic5/Q79UvpsfUC3iG0ZdfeLl2awg0L1Nzn1Xtu7+WNvZQOENcTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e7f02f-efa4-4762-08cf-08dc4212a40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:31:40.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkjCPojDxNrrC4ZxC0RJvy012Z/a9moCTtbc6pQqhqPLbjZv39NFJO4EF96szy9gccjzVk3/GFuriTY+EV1kKETXAoTF+sdEz+lET3ldPHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110166
X-Proofpoint-GUID: 2s_pNXXY8UPko-rEPuBwe0rXIllVOPTG
X-Proofpoint-ORIG-GUID: 2s_pNXXY8UPko-rEPuBwe0rXIllVOPTG

DQoNCj4gT24gTWFyIDExLCAyMDI0LCBhdCAxOjE44oCvUE0sIEphcmtrbyBTYWtraW5lbiA8amFy
a2tvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uIE1hciAxMSwgMjAyNCBhdCA2OjEx
IFBNIEVFVCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+ICsgcmV0dXJuIC0xOw0KPiANCj4gTWlz
c2VkIHRoaXMgb25lOiB3aHkgYSBtYWdpYyBudW1iZXI/DQoNCkdvb2QgcG9pbnQsIEknbGwgY2hh
bmdlIHRoaXMgdG8gcmV0dXJuIC1FTk9LRVkuICBUaGFua3MuDQoNCg==

