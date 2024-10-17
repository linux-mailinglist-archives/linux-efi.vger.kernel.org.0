Return-Path: <linux-efi+bounces-1992-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380D9A27AB
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D971F2311A
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130661E00AD;
	Thu, 17 Oct 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AfXz75Fq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s9pRYs1r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3A91DFE2A;
	Thu, 17 Oct 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180617; cv=fail; b=oMNyh4BqE2MD/U7nafzDNybiREAN02KLG1uMWJiRFpgMKvMJVhP7PMx0SrHKkQ/AXWnJPaU4JbjoVb5AKCPKftLpVASjOhjj0IpJXtOnCpBjbuU8MNtKGi73gday9pWipTIvfdOPVG62jFWMwIIx2fQpORpPV6fWW81UugVPPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180617; c=relaxed/simple;
	bh=QYrBbZRL3Pzrup/FbP+45q+pVLMKDvw+Kg3xsK9FrHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTjTm0Wk6UUyExHkqKBh49jLNr3FJVmm3ocjTOgS5rQ/PC2cp1TvZESCejyi0eFVW6gcMIvNSI/Xv0arH+s6lEiUCou1rYxJYBEoyf/Cc4IYs0TDP4WAmkOPSd4r7Lrh/epxPe9FtTUNA3YiqXS43NRJD5aH6ZXvBTHB+rKv6dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AfXz75Fq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s9pRYs1r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBpKI002238;
	Thu, 17 Oct 2024 15:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jiKVptX4xdkm8eHptFSicuf8wuGcNFVT2x3AbupQFaU=; b=
	AfXz75FqlLtyT5Aeq0bFTc6AL9Ux75+4Fh8NZGMA87ldWVjR4nHRrBASboVhUuBp
	plTkOp0oTh5We0FRC/6sY2Qh1IQJg4o7KuVLuSZdVD+4PizPC6NqNOAk374R3NyW
	meL0I9N8W2Rq4bDeRve6bAPseSrgpG8xh+0USUs8C8O9kNd37P8PdAb7Oi6Yt8DB
	MqLSCsvILMwc2lXr/0r0X2k5ciHt9+ap+Klga8uMjtxjrucAo6H0rLc70asWwn5l
	B92i6C86MJCQuVlXpl5mZJgxKKHBjX10FtAeddfSslKj3J9GhvAPy6qbT9c5YFTH
	ctHliBUw6PY8AabBlbSAhA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2pxeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFPSY7026291;
	Thu, 17 Oct 2024 15:56:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej31-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJq5yZrEpkQfWH/3y3Bn+R7uzh3LnBTRlrs8CEq1Zpmd03y6ZpIaBnVKQdZWX1H5pnMLatC06+nOFDO58N1gqG2paAbzgqs152iKf/Jzv5T974oWHw9TV0teY2zAhHlfR/iEvJSraUUSDvQf3mLGvcJlLkBDHqGIcOmF9uf99gRQQGYBEKUMOfjbMgh/tdy9GXkmpSEi8LkEwMyVZE3Gtl9lQLyYQOrVv8f6jNua3VwrSKVs8C2UDHfjFlGdIclx9W2i4TEoXb0dI1ZixytVZdnQOFHhO77eJdJKU7BWUtFG8Sqw9Ib+pMAYpq/52+n+Gemr5mjwKcr6+b9DvsxFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiKVptX4xdkm8eHptFSicuf8wuGcNFVT2x3AbupQFaU=;
 b=oXNCq1CTmNtLh/I+uMb7DQ2AIB5W+uH56fq/Jj0OvA3a1kCGSfhNSxXuGpW6CosSdXFce0kNqclUqIvzLEsOkIZFMdzbhdu1z8y1S3uMlZP+1Z0XpmhZcHPFNYuafBpYEHXtnqXMAc5/cKvt/kjt6cuEYc/1surVX4htHgly+HDJvpkTlugJDfJaGBP6YEppl6Gvn/6Xv0t87C94gtQAUJ72jn+A5EEz+339HunJdIucJRf3cMeX13MChZ/b6+rN7OUwVrxvYoSW1Ogkmxm42WJ6ZdYU/D/3eDbTiV+I4XT5qtDsvj2vIP2Isl/rYYRBIk1baIXeTkW0rax3rABSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiKVptX4xdkm8eHptFSicuf8wuGcNFVT2x3AbupQFaU=;
 b=s9pRYs1rdv1mbDfaTAf+Qulu+zArQ1oNZW5pxnA2t1N5OkgcE0WEY96dVgcFbxk0Rcp8fsiQ6Z5/TCgfnbUbqk8FpSl2cVyA0hv7ParalX4aJCpE6TqvnXW/Ix9FjWFCWCX7cbN6lAz9EnBW48qF8Dbas9yQnaETUxuDvfMvgzc=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:56:04 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:04 +0000
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
Subject: [RFC PATCH v3 07/13] keys: Add ability to track intended usage of the public key
Date: Thu, 17 Oct 2024 09:55:10 -0600
Message-ID: <20241017155516.2582369-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:208:23e::21) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d4ef8c-5e71-449a-83f1-08dceec431bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b0hTut6HNSitoRhHeFUO2rIE/cJPIpR80znCoAaFB3VAIaJfFfbQy8LJIGOD?=
 =?us-ascii?Q?L3ugshodt5Zmzcv4ZfBW7BhnCq6zH28ie/9JVhZMHZjXJt94slRYCQtcBV7B?=
 =?us-ascii?Q?qjVirMxyBl3/FweAHz07bGIfk26SLZ9J6In5jen1rJ4g2wqxzIw5plFsTwvg?=
 =?us-ascii?Q?GGqTmAQgKR27ckTb5c5m3tuG6H35IDrPenTl0+TGMIqK4UGs2/99EqnWO8XF?=
 =?us-ascii?Q?03lplMOe/+4QfuN9VHbr4eYRV6ZVmwWpjtLZDvVpPJUeF84mVbJdYOhv98ce?=
 =?us-ascii?Q?9zJ0qbnS1vXD/eeKPJv2aqnHo+0ZbInOuqkshNrbdxUBLdLAEvLBaA9HJedU?=
 =?us-ascii?Q?uccp/HBK20lkF4RKeGi8rVfTQZE0inYdG3BtbWD/Zm5FVmVFIhbxDOQDEdAy?=
 =?us-ascii?Q?DlaPqybyUqSHIBjvKQgvlXBt2h+FyUU9bC8kLW9XTpt1DwYoIvDoD0m5GxHt?=
 =?us-ascii?Q?FbtjKyV9GLPgz2qJs1DH4sRwHlOK5BdgydYhqHWRuVPovzgPr+bzlcW6yJr3?=
 =?us-ascii?Q?XzDSL4Yw8YRAmVlaC6AILdikSqOytyqHV1G3IV09Cy926GEFK8j7337S2aku?=
 =?us-ascii?Q?ymFmKCXrLu7GFOJDdYstkbZDKBMkMbA9DOu4Tgdruls7MqcLTIgIAh+3THc4?=
 =?us-ascii?Q?+yNGl5bD7io9Xrme8lJSpXsFUi962vs5njkbNtqTP8MGc+xiloOGpgwApana?=
 =?us-ascii?Q?x2jlYizrd0wjtHmV0bY9IixaDucc/X3IOnyJ2hKdWbh0tYh06UyH3n3RPIeV?=
 =?us-ascii?Q?q7cralH5kk/IGOGt8EEDMaWJo5yrvuN/OYmIkU4cY59D4U3rD6TR9NLkZkdh?=
 =?us-ascii?Q?5smjRDea4JkEHSvmIYmPcUp9DnbUta2RkXu6FP+QybvW9CPe0a28lEfWLpQw?=
 =?us-ascii?Q?X1pD+b0iQPsawaHoa3DzooQThSB0NLHF10PZ77scN1aRKB9vmyzGei/pD/ug?=
 =?us-ascii?Q?T+Uh+HP52vl99tLhDHUO62te8jEVgY9eQZcFNprJ225IpD3qgaHUXDWXkW9z?=
 =?us-ascii?Q?/cQ3fCCdQ/SgOvs0ZYwjqZpNjlGbNjX9pou9LAz6to9O3DoEiEdCysVTlHIG?=
 =?us-ascii?Q?b0zS+N8C9e7ILmVlKgw1/oAYnt/zKytEaDIS/qmCylmp9AXg+OPAcC6EdNBn?=
 =?us-ascii?Q?TMsGI6kZi2ShpFdNRztfELDRFzDdYJYI/yD6PmP7ihwQbMFQfsD6alpGPEww?=
 =?us-ascii?Q?9IzzVInDL1/CNGTdUm8ZD2Plvji1qOAaZXo0uCZ1a2X7wFu3UTX/KhaoYlg6?=
 =?us-ascii?Q?m2sS18PlX/plsj9Dh+MtNKvaEhE37NmrjfV7hyA2R2Y9/TY9mCvWQbXB4ojQ?=
 =?us-ascii?Q?HJdwn0MRV6sUCtvqhXDxjGFx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yObkmPhmGnVtIuX6ujBIM0L7MRwByaXRtVtUNV1M70n52Yr6cErwcxmP2HbZ?=
 =?us-ascii?Q?ZJD/ZD/iwb3bTQ4D8/k2JWq6dE7t9Z2GwGBnBeY3RQ2uaH6+91jCK8rQIoP0?=
 =?us-ascii?Q?GxRcIUPjiufkJ+DeoGDACqPnKZxI2N/F26YOcAwi5k/SIkXyjAT0K8B57/Np?=
 =?us-ascii?Q?p8GGjNS01k3HOyRpFyNi4aWEea9rxDLoAlkqamWB3uii9tiCqDhTZlGB1GEs?=
 =?us-ascii?Q?qb+bLtBcPWLq7W1bJIoVi/jzcgV2ynLXpzk8+n+dK0gzedCohGotM/kceR+r?=
 =?us-ascii?Q?L9TpdHJXys/rDU0AyuIAw37bGJCZoGIB7+yKM9tDw5KxZ3XJyY64tBu9ptKB?=
 =?us-ascii?Q?qpBGUOYvnJLQEE3pWl43W+2ypjqy68EZ40NZ3eq1JTlOzr1v/WCdEzhHLnnE?=
 =?us-ascii?Q?Hk+he38XblW11652WW1/ulIGIj0jz5TJL05hp9mNAvqgX6zhSXHzpI8PM4Fm?=
 =?us-ascii?Q?Ve5y33j2rXrDhT79ZiYA7nDvEI80eMeMBic/5uznGbI7ogHufGnODjvQ/5Wj?=
 =?us-ascii?Q?cjx8FfTjbKtpGGmP/kjP3cci6mGyPBvIt8vee9y7Ie3vGPHDp19Q/oc66QoZ?=
 =?us-ascii?Q?uY3EOg3ttV+pTqSKwt96m9Bvv6GlmI/MmEUwwtCpyrBHoDLwyB1HB2sig7Bb?=
 =?us-ascii?Q?6GLmWVoV32U/EWxXHrAQEwccIv9u3gZINcg0umLbe5Kj4xLVu3L1hZCHSKX4?=
 =?us-ascii?Q?qLimebXbm2FSqBlJMlIHbqGmXtYQXaMxP1iK9m+6lpeyN/5aZ9FM28I6/01Y?=
 =?us-ascii?Q?l+IwV5/yQ3nklv3Lk5SNNsGGHHDD41ErOGrv6QNIG09Syno3JuZJoSULPrdl?=
 =?us-ascii?Q?fRGothQFOO1x62VPksxDW03qKbA8yM1W8D8scFJePZPWgFRD+srDqBhiYl+P?=
 =?us-ascii?Q?TEX6sQFjFvVVZO4mXSM4fV0E4xtL4I4OD7FFpVXTiD3pHUN0aRNinp4xAULP?=
 =?us-ascii?Q?bqdTP32hVvO62Y9fUOosusIMPeaIwPjRRKD4RFzhH5LBYyF81tu0aXq3bjzb?=
 =?us-ascii?Q?XFZuQYTynV1BDnKXkxF8Tha3BlVlnS9MVQoodxDwj1L25gRWGH3iPWeE7i7M?=
 =?us-ascii?Q?wpK+Fx29OiU11h0aSAoV7l3thyBUsnHFeiDl38ytbYpsmCcI/DSoAQiLqbat?=
 =?us-ascii?Q?B0JSP8AkOw9RIQN7MmlzdncNepZlGsrCB+AS6VToBkfTPvtcAUOpo9kwhK6h?=
 =?us-ascii?Q?zjR7f0cW9KEduofnNQB706ZFbwOkd+9xG0Ssc5eXOn2Vld6gZ8bvl8A43bfq?=
 =?us-ascii?Q?wsdqrcfp65fnTm9BBNOVRPGh0/MHnzWw6TXNCHoRWNfqhfFWWfHPUOxXmOKS?=
 =?us-ascii?Q?rrixX6xmD14P6Ljp9bmuz13Vcc/J+FUnm1zp4uujVvAMSmQ9CZQPHxov1Dj5?=
 =?us-ascii?Q?hf8E2CINczq6wVAvSDOhpxRMXbIemWpWUwPVUTQAcoRyIKWD1+wnPQDrU1Wi?=
 =?us-ascii?Q?IZgcF97oX2gaoHTHDb2GLfYO0zzz9brIUBJ+m6YIP6BpEyrGh1MHxWKidaF6?=
 =?us-ascii?Q?tbZLlQ5hxVRypa3BNNgJxc01FAvvnrCGhNpPiTkb+ht5arM2FfPI2Jt4I8zQ?=
 =?us-ascii?Q?ApDjTdvqqgnmAw8P82njQ5FCKyYeEAb0Z7A51Z5pPyr9ynh6Hxk8GynKdrKg?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dtc7a372gRqnBZWn9RId5zo//6XBbtD79OUGJcfxpaidfuH1F+owN5l/PFbL3JYa+vwlCXdnvJ+Fs8yP88XMQXoP9LUOAAwtdbksILP2ZW2Sv8xLJbwgbYYV4kRZdt4II+eb2jyOlGKzETIOnfXD7DwK1sxQC5bexWG1V9IbJbI0HWEpvQILptEpZL2Mai6U/3H25eIJqV4ejxmlFQLWwD24uKP1LGX5YTTPoLN/3ZgtdB/HVUsnpHBE/EcTd/wjRsX3ftQnFA3CztU2udJmA3NXwO+w5bR0PvqvtHeF2gJeEii7lajzY3AnLZChmfCYzl/P4Hrth+kHoeL2/UUxn2wRdevLCjUNRuvCr1sdLjQw7K5oAybeEaEUODTxUa/o8qvi4JUsnajzs5UJZ79YgLAOlEFG4TUBuiGOo/lWsHz3IiOSchxIUFVmuDY8XLlTtDmw52w8PkatHcqPsL8Sopszof/0tvTfI+PuVytdaHLNsvTwgdBDakzOYhtXdPDumTL2VrHfZy6tmd6Lw2jA2iodqR7Uwx2SiSLKfIe/u9c+IfNF+WMNWXZRKRrPlrDRxsLkYpz/vvx7JqGv1wKz63OYdb9c5cGktiZKSLIh5Ug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d4ef8c-5e71-449a-83f1-08dceec431bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:59.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSe52VJFLNZuVV1p6dbty90ej+G8FkcNhx512LJLpcQT7xYpsX9SvpVLXoaLiUoXJpmddIKBsfPfHbhz3RPFyHX8lMK791QqiLikoc5nSAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-GUID: zmLgbRBLLgQcn3q7s-NuzCni-neCwCal
X-Proofpoint-ORIG-GUID: zmLgbRBLLgQcn3q7s-NuzCni-neCwCal

Add two new fields in public_key_signature to track the intended usage of
the signature.  Also add a flag for the revocation pass.  During signature
validation, two verifications can take place for the same signature.  One
to see if it verifies against something on the .blacklist keyring and
the other to see if it verifies against the supplied keyring. The flag
is used to determine which stage the verification is in.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/blacklist.c                     |  3 +++
 crypto/asymmetric_keys/pkcs7_trust.c  | 20 ++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_verify.c |  4 ++++
 include/crypto/pkcs7.h                |  3 +++
 include/crypto/public_key.h           |  4 ++++
 5 files changed, 34 insertions(+)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 675dd7a8f07a..dd34e56a6362 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -17,6 +17,7 @@
 #include <linux/uidgid.h>
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
+#include <crypto/public_key.h>
 #include "blacklist.h"
 
 /*
@@ -289,7 +290,9 @@ int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
 {
 	int ret;
 
+	pkcs7_set_usage_flag(pkcs7, PKS_REVOCATION_PASS);
 	ret = pkcs7_validate_trust(pkcs7, blacklist_keyring);
+	pkcs7_clear_usage_flag(pkcs7, PKS_REVOCATION_PASS);
 
 	if (ret == 0)
 		return -EKEYREJECTED;
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 9a87c34ed173..64d70eb68864 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -131,6 +131,26 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 	return 0;
 }
 
+void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
+{
+	struct pkcs7_signed_info *sinfo;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
+		if (sinfo->sig)
+			clear_bit(usage, &sinfo->sig->usage_flags);
+	}
+}
+
+void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage)
+{
+	struct pkcs7_signed_info *sinfo;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
+		if (sinfo->sig)
+			set_bit(usage, &sinfo->sig->usage_flags);
+	}
+}
+
 /**
  * pkcs7_validate_trust - Validate PKCS#7 trust chain
  * @pkcs7: The PKCS#7 certificate to validate
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 1dc80e68ce96..44b8bd0ad4d8 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -455,6 +455,10 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 			return ret;
 		}
 		actual_ret = 0;
+		if (sinfo->sig) {
+			sinfo->sig->usage = usage;
+			set_bit(PKS_USAGE_SET, &sinfo->sig->usage_flags);
+		}
 	}
 
 	kleave(" = %d", actual_ret);
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..6c3c9061b118 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -32,6 +32,9 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
 				struct key *trust_keyring);
 
+extern void pkcs7_set_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
+extern void pkcs7_clear_usage_flag(struct pkcs7_message *pkcs7, unsigned long usage);
+
 /*
  * pkcs7_verify.c
  */
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index b7f308977c84..394022b5d856 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -49,6 +49,10 @@ struct public_key_signature {
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
+	u32 usage;		/* Intended usage */
+	unsigned long usage_flags;
+#define PKS_USAGE_SET		0
+#define PKS_REVOCATION_PASS	1
 };
 
 extern void public_key_signature_free(struct public_key_signature *sig);
-- 
2.45.0


