Return-Path: <linux-efi+bounces-3340-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8094A8A9CC
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 23:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84EB3BE677
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2C222578;
	Tue, 15 Apr 2025 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBVIw8Wm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y7sKb8No"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B47253345;
	Tue, 15 Apr 2025 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751096; cv=fail; b=tSK8s41rEL/WfnKMxe+Q2e0HRcIy+nZlmsRdzdKA2dH0Y0t24m02muDQMjxICzwWZDHH/s674pURTOJ8L5tNsa7dqt16GRGdTs+UjZ7mev+XCcKg+BZSI/RV5V3SMydOzXu5Ajt78rX2o0N8YO15d9Lu+ADM6LWbviak+ssJTLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751096; c=relaxed/simple;
	bh=dTBe9HvbzNP9ef/zFZM5ql/pjAg2u1lbYEA1iSh7SjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ER0jKLRvCWVhEUwNn7hr9ik109WDzhQCDAOCvgj6sUgumTgI87DD3iPlEQIEGd94b/kXlbJQBhQMUm4oZEwJBaNrUZu5EmTwKWC8hzYMxcOchWRtCBklxuCb2cBTD24ZBehFsxhrh+zvrWf0IFGtKcqBegtFIFM1m5ggOqop9Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBVIw8Wm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y7sKb8No; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKu1SK027999;
	Tue, 15 Apr 2025 21:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oRczYxky/OY7LF0rYQob8VGCJkCyz+sM1kmgq+L+bQM=; b=
	hBVIw8Wm1WmOXeNW97FE8OOCK5qrZ/U8D2FVdSQ9SWsiHHVTokLB1ocKXRmTtsT8
	zHfg2K4FLtNBl+16ly7TLmPtBD9I4vz3sjhteJsjjrHzeQMF7iVHM8MegLwy9dHx
	ST/bZgBAoKFgJK0I5cvWZujKEHdZt9PYlIrzEUBoHTAQQSty28nkOOGuQ3KIXDHs
	aZ/M1FpixVUKH9uKN66jlzqW2q1u02yGI2DmoX4pDhLUQgjNoBt504UkoFKeHura
	a+AKpqVFqR/wCs/18rxAFx+krjMQcqKVWW/QlbuwlwFSn21iAke7aJUiK0Cc7DMt
	0V3GNPaz3fj3i2TPJON59Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180warsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 21:04:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKd1nu038888;
	Tue, 15 Apr 2025 21:04:10 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4ry1y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 21:04:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huzlLHXNc9+VyM4XZTqvqpqO+UbmTyJ+suBYrmkBwic5nHK6pZWZd5kkN3j1gsvzFHilC2+2c0AgvpK6AGwDlRDswOz6NOI5jt4vdpuv5OZvUuoQ21MWURnrmSmrcONUS7zMPtadccKK47zKGArY9XHJEME+KLEyv7NIhPVDQAE8trVrV0H5vTB8ZAm0z6HZjqYv4jPZu6VfqYNEKP38BTw3io+aiYpbpCvye5SBMDo5d/czqoQBgkt/gFaCZNkom3D4JQZGECwjRt4OK9DkDkfJYJmawmTPIcRgfu77/mITdhTTkdRe1nGite5Au+jgAm1HEQPILUCltZD90UVJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRczYxky/OY7LF0rYQob8VGCJkCyz+sM1kmgq+L+bQM=;
 b=tDov2m5ry0CixWwOFfVGkdkUN8C206Mdkgmvm65ziUZBikpCw6vVxi0J4+ueDlcRp6vWCYEhuc2P7ngqU2VHzoX8GRyghSRDeV9EPHLPlHjEa1bgvAtmQWv7mGpmti0rbmrAXdUciHMrLszdteL06ZGlEa33TEQhxcmGyts1DEV9ztazC2V497iNaIDLt0EfoR9xOnDHuPiRa+RvvtLSfMtrx6bnlKxUj/nOOpcfG4Dax15mR21h25eWbP83zxC8JzYIbC9wEakKaF+p3Tes2uBEsbxU4vtD3auu7lAH2E+SbicCHY2FTSlVZrfp0ypWxo0YPbkCGj531vZwn3bs+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRczYxky/OY7LF0rYQob8VGCJkCyz+sM1kmgq+L+bQM=;
 b=y7sKb8NoYNHPngt49Xe9xmXj5kZChgErxf+WUPFS6dInbYiH1Thiy3IGxdly3w2iItp3nU+8nR5mIOuwraHiXA6q7vukjGz97iKnoxQK9i7UeeCFYtXtKvj7p0nQfP+7cbDCy/UvJ2g+8uNc/lhT8+XxuuBDKN6+0XYw73d9Fsk=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:04:08 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:04:08 +0000
Message-ID: <d2c23029-307f-4691-af13-e57bedd2ea33@oracle.com>
Date: Tue, 15 Apr 2025 14:04:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/19] x86: Secure Launch main header file
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-5-ross.philipson@oracle.com>
 <0e40a1d6-34d7-4966-bc23-34c0ea15ea29@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <0e40a1d6-34d7-4966-bc23-34c0ea15ea29@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f49998-62c0-44c9-ec28-08dd7c610fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVljb21rcW5RSnJ3ZUc3TkRrd28rcUtuZldTYTAxeGViMkZMd0FMRUw5TFVI?=
 =?utf-8?B?T2QyR0poaWZFSGNuTlByRW5oWEtmM0xlZ2dJbHlBWU1QMi8xYVB1TllnamN4?=
 =?utf-8?B?UU9GSGJhVWJwV1N5YmRsMTZoUFM2N3dWVzV3ZDRRYjk1WkgwYUhOT0ZjSkx5?=
 =?utf-8?B?WnJveHZUeFBrcHBKMFkrVmpnR05KeFRZS3QrSllBcU41NWxGVE84ektiMERi?=
 =?utf-8?B?S3VDc09zcmdja1hTODRwZ2cySlRkK2RtK3crcXZ1OXdpU3g1MkdJU3FNODAx?=
 =?utf-8?B?bG14YXJTVHFOcnoxZDhMdW91cUxkZUVmRUNYZkgya2RyT1YvMm5jalRrTXpy?=
 =?utf-8?B?dXRVSUpGRm9sWFp1bWhlZDdobGhHR0hCYTRkQ0NBaGJTREpPNG11RGtFdTFq?=
 =?utf-8?B?MmVyaUdWdXAyR0FZdmNJeDd4VnVwbDN0ajNmVS9jKy92TzhYUEplYjh1SUtW?=
 =?utf-8?B?VkdjVzBrRy9HYkhQelRBUzZLRzRJUEdPeWdDYk95WmZ6MlM4cGUvOWVBMi93?=
 =?utf-8?B?WEdhbTM0YVFBNWtpcXQrb0Z2cmNnVGJMVzB1SjlQa0trQkdwMTBrUEduNUhy?=
 =?utf-8?B?MENTUG5QdzdBUHF0b0V3QTVWaWMyTmMxVTFObnZQZStQSFEwWDBFcktVcStP?=
 =?utf-8?B?cDM1eDZIZDg4OVZEZGV6TUc1LzJUSW95Ri93RGpQQ0tHcnpnblVSNk54TjdB?=
 =?utf-8?B?aG1HaE1YZEJYbG9QSTc3WW5JRmI5TUlac1dOMDVmQW83OGw3cnZQVFl3bFU3?=
 =?utf-8?B?bEF2dzFHRTV2a2ZRODh1ZHBSMnh6U3dsTUhSekJndTdpLzlzUjA5ejJ4VGRv?=
 =?utf-8?B?blROQ2NjSkRFV3M2aTZyc2c5cTRBWWZORm9HbDBlV0dFclNvN21xVnZHZitu?=
 =?utf-8?B?TlZLeDlta3VpcDZMRUZFa0pNM01RRGR0cVh4d0pqKzY4TlZObUVqWlZlVmJN?=
 =?utf-8?B?T3I2aldBRlZkamt0N1NHWmlESFJtUUYwZWlCRHdmREVHS3d2QUZaVkNBNGRH?=
 =?utf-8?B?MWNxTy9UV3ZrSVcvWlROd3VrTXoyVGhWai9oY215ZnhBcHQzT0RZcGR3VzVE?=
 =?utf-8?B?a21xZU96cFN0TkRDSzZwTG9qOVBHN3ZmYXpyVXpSOENhT1dmbDZOdHBCUGNB?=
 =?utf-8?B?TnFjNWF1Nmk5bTllajU3V29HcnlnalFYSHJpaFJQTUx5NnhEMDlhVmp2Yk1N?=
 =?utf-8?B?a3ljT3pjZDZuTFBjNGFNSVdLK1dNTXluOVd2bUFmcXVVRXVZTmdYSWNqNkVn?=
 =?utf-8?B?bmt5a0xjNEhXVnQ1dFRZUmE0OUtuSWJFZklGNnFUSFF2ZnVTMGVHMDlza1VQ?=
 =?utf-8?B?NksxQ0tXRDFyL3l2M0VhL0pVMmhHMzRDL2RnYlNlR2NiOW85VHpKRkUwMmU4?=
 =?utf-8?B?S0ZDOG9oU3VqaEsvUkZwNldPK096WjRhd3NybUk0dGwrWkFlajVNZ2FHMnVW?=
 =?utf-8?B?cmRkTUJkbG1HMDg0TEwzc3VQOU16WVFGYVp6WUhadjQyMEJ5VEZkM1Jnbm5l?=
 =?utf-8?B?SHZ3RU5DVjZHVTBZOFdOakpRN1RzcFRpNG1ydWx2TDFOUnpjMG9HTkE3dzRS?=
 =?utf-8?B?Sy90T0VDQ01WL1NXc1FMNUlmc2VrYVYyUXlWUElmL3QyeHFuazZuZXZRZ0x6?=
 =?utf-8?B?SW1NR0dOajVwVjhyVlBEcjlMcUpmTUpjL0JBRDlNQ0RZNThZUUs5bTVkWW4x?=
 =?utf-8?B?alc3Z3IyQTBnTTBZZ0hpL0NVYU0vSnFBaFFicUJHMWpNbWdRTG9lTE51VmRU?=
 =?utf-8?B?bzRBTDIwaWVha1BlRStFU1Ruc0ZDTFlGSGNWNFM2Rk5vbnZEVVRhNm83d3N3?=
 =?utf-8?B?Ti9nZi9ZdWlheHBITG5RMGh0cWR1N0RKUWh4VjdlWDNaVTg1WHlKbGQzVnFx?=
 =?utf-8?B?UzRvZ2F0bHdxY2M4MmFDb0lUQnZJYnBJbW9FVnYrS1BVTkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVVIRDdnTGRqQU5oL3JJb0FjdUlHVll5aFNqNkFYc3J3eldCWS9hVlAxUmhu?=
 =?utf-8?B?Y0lYVXhBQk5RWE1vMzllcEN6bUtvZzU0SDFIRHpUUlcvZm5ud1ZxSmlad2JQ?=
 =?utf-8?B?d1M4QkNrQTFaaWpMUnQzd215dHpQakFzVGMwNlVOY29Sd1Zla00xV0lJNWhG?=
 =?utf-8?B?MHNlNlM5bCsrOXhkNkdxcHRwVXBIc1g5NUszUlFLRWFEbWVvY2VTWnE4U0Vk?=
 =?utf-8?B?RUNjWW5zajdZQWVMWXZOMDRlNFhkdGF3VkxvaWc3SWxBc1hvNWFDNnFyeEJO?=
 =?utf-8?B?YkFQcUJadFR1M3UvSTZKQ21tTHRSOVorWnlOdFBSa3VNNDRCM3BHTkVjOVNY?=
 =?utf-8?B?UFJxSDZqTmJURUJ2czRZTFVQUkVYTVRjcUtnb3l1K2FWMXM1WVBFMDBCLzJZ?=
 =?utf-8?B?NXkyVFV2K3hma1c1K2l6UU9GVnZ5VmFBZHhsdVRTV2JiQU5MZ3YzdDh2V0pw?=
 =?utf-8?B?QUk3TWRTM09kMUp1cFRwdVNrVTJ1OEhuNVNqdG5mNlZseHp5YUVaUDI2OXVz?=
 =?utf-8?B?Yy9peGxxWXpLTGJvRk9IamRFKytVY0I0a3ExRG5zbXNNYXI4SmkvQXJuVG51?=
 =?utf-8?B?Y2xCU3AvZ1hDZUdUQisvbkRLeHA0Nm5kcTkyZk5iL1kybEkrajZpWC9uK09i?=
 =?utf-8?B?cHVnVW9hYkN5STRBOXV0dHZIMVdVTjh1c1pwTHJwN1pOdVlDZ05HZktoTDl6?=
 =?utf-8?B?RXY2MlBwc3Vkc0xtQWV2WWtBa0x1ajYvNWx3QkpsNmdQbHRuTkZrT0NCcGIr?=
 =?utf-8?B?T3hqTzdSK2s5Z3A5aVQwMy8rYnZXS1JzOU9jVjV5c3VQZ2FmbUtJcDFzMXJV?=
 =?utf-8?B?ZFpjRDk5SlI4c25FdU80aWlXaXRWeklsbEd4eG1IVk9aYnVuZmlZWE9Lalo0?=
 =?utf-8?B?QVB6VVkwMjRzS2d4T0ZQNFEzVm03WXdTVUV5QmEzZEVnNTRRb0dmeU5VRDFN?=
 =?utf-8?B?aGw4SzNEdFk1ak10dGhyNnMvdE9sRm9OVThXTjkzU3NXeXRyZmJZVHJWUGtm?=
 =?utf-8?B?ckJHMXNWblhLWTJEdUZjN3BtYXJLVTB5R1RDdWRhbzArY2ZyUm1PQU9Dc2lK?=
 =?utf-8?B?YTh3ZnZnaFpVeWNMeW9CZ2ZvMENJRFIvcTBSQ3JZcktDM3pSZjFsbzFVNmZ0?=
 =?utf-8?B?TGpUZTJaNVFEVklDOGJROFZzRngwZFJGMHROVUlzOXRVb01QejNKNEU3ZFNU?=
 =?utf-8?B?VC9ONzNJWWVJOTVNeDVKWGtITnNRS1dCUCtTbFNqTFV1L3lxYU5BczJuYjcv?=
 =?utf-8?B?TDk0TkZYRTc0WThuajRWdDZBNDZyQXYvTU1ycUs1RUo5VCtpQmlCcis4eWR1?=
 =?utf-8?B?QjdKVWUxRzlyRDA4YjBFZUVudEYvSExZK2Y4MEFIZkRWRTBhQnE3K1hPNHpu?=
 =?utf-8?B?ay8yWE9mbTk0Nms3V0dyZjZzZWVaRFJVT21QbDJka3VzSUxtNjd2b3I4Qy9Y?=
 =?utf-8?B?dHJweFExMnlDRXNDREsvWjhUbmlYdk5tN2wyMHU2TVB2d1NBbURoWHE0SnZM?=
 =?utf-8?B?WXNFMEw4dWdsSlBkUnpZY1RSVkFRN2V2ckZqTzVORDVyVEVHMnBDTmgzRXhS?=
 =?utf-8?B?YWJqcS9UclB6eDh1dlB2UjFCb3lBLzJrZkRtVnQrNUdUeklHRTJmUkNhWmln?=
 =?utf-8?B?WXJRbEpYYVRRK3FGc2ZQSmRvZnVHclZvNVRudWd5QmVCVTh3TThaTzdvZncz?=
 =?utf-8?B?dUZKaS9EcUhJUmZ2VTFuUWh3UmdMSklSY21UTGYvRG01UjdZSDMzcDdUcU91?=
 =?utf-8?B?Z0lOTkY2QWxURnAyMmlWbHhxUjRtbGF6ZjZRSk5JMWI4cGdQVVVGOFBzV0E1?=
 =?utf-8?B?S093RGRsYTZtQkw3SWMxclVqaitMQmtJcSs4bXRoUGtwNmIrZnl5Qks5eGNh?=
 =?utf-8?B?eWhUeDhReVg4a0g4NEFGMlZRdUM2QjVWQWRocmtlOUlPbXhCVlBWVXhZTTVM?=
 =?utf-8?B?M29xSFBJSXFFRVhFOHpxRXQ3SmFYejJ1dGJ2ZHNveXRZSy9ZVnVVNHF3Y3Zj?=
 =?utf-8?B?dXE1cTh0Y0t5aVdzb3dNL0U2Z01EaW5iRVpGYys5bWN2MFBvMWdKdXFyZVZt?=
 =?utf-8?B?cUlubEJDcnVKTllybjJrdzJwa1JpZjdWSldDdG1STVV4b01jeVpTL255KzFH?=
 =?utf-8?B?UHd5NWZvMDFEcXc3aEg3RGljUkpad0JsRUlmTEtuc3haZEpLT0pVVnBRck1Z?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z1mLUS59qsuy+1dnCc+9QnuC+ChMFEmfGRFT5ufgYzlIa7YnKq9NpFbhcfUAIzI0yA7+djRla7K0y4xSA7T4uki+rNpwK62DkL1Hq1kB+H4+VAQABP403j7+riKnSucMxDmVl2bfz+LXp4KhHM1RcdPdn27XibnO1z3atS8PLuiIv7K+ybL8aT7byzQ8GOBNZl5DU4WdBJX136B5Wn6jjdCnfznC6iGZ6Fj693Ud3mhQOU+1PdOkE7SNqRRzI7bjPCoD4B0t9f3m5nR7/DoCIm4qdWF92KWdIUy2Iv0Dn/ieG09I0STGMYHDjYmvtkA7C+vgx271vpDKp8YspRU3TKJF8gm0NTjKib723oEqlAz507UydKr7QNIpU9dzPSpLyvXkx2x7eLUzB/A1cvsRrsXUDuIYyV05LE4w02bEfzYH1Rm7qUT5p4KgetqWU4cNOolt7FTx6Bl/W1/ZTK5GeyVEmVDbyjV7AKyXWx+UurPQ8gsvljdRk7YmEnpicOHs2wEZiMkIJjWSNSFtVKxznG/f9896Hg7Y3LbSdUzAfN8qQlQfMHNyI2nJYkdUZGOAcgmd4ilArf6CY/XvSkDzNSAnDzyZ/X3+xW0TJmtxytU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f49998-62c0-44c9-ec28-08dd7c610fe7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:04:08.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACPV4T5rKV0Xz2SDjDrF5cWnuRENjlBnK6XM8H/0TvBi0TqSwchjAImgd64pK4FEEYWuvPoyxh1BAjYAcNPjKhp7BV2DNf1XB3s4K37ahgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150148
X-Proofpoint-ORIG-GUID: AZYGEByv5e-IRZLZUDIe4G8_CjUN6mIq
X-Proofpoint-GUID: AZYGEByv5e-IRZLZUDIe4G8_CjUN6mIq

On 4/12/25 11:34 AM, ALOK TIWARI wrote:
> 
> 
> On 11-04-2025 02:11, Ross Philipson wrote:
>> Introduce the main Secure Launch header file used in the early SL stub
>> and the early setup code.
>>
>> This header file contains the following categories:
>>   - Secure Launch implementation specific structures and definitions.
>>   - Intel TXT architecture specific DRTM structures, definitions and 
>> functions
>> used by Secure Launch.
>>   - DRTM TPM event logging definitions and helper functions.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
> 
> 
>> +#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR        5
>> +
>> +struct txt_heap_event_log_element {
>> +    u64 event_log_phys_addr;
>> +} __packed;
>> +
> 
> can be consistence with PTR

The names come from the TXT spec for the most part. But maybe it will 
look better if I change it. Will see.

> 
>> +#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1    8
>> +
>> +struct txt_heap_event_log_pointer2_1_element {
>> +    u64 phys_addr;
>> +    u32 allocated_event_container_size;
>> +    u32 first_record_offset;
>> +    u32 next_record_offset;
>> +} __packed;
> 
> 
> 
>> +/*
>> + * Find the TPM v2 event log element in the TXT heap. This element 
>> contains
>> + * the information about the size and location of the DRTM event log. 
>> Note
>> + * this is a TXT specific structure.
>> + *
>> + * See:
>> + *   Intel Trusted Execution Technology - Measured Launch Environment 
>> Developer's Guide - Appendix C.
>> + */
>> +static inline struct txt_heap_event_log_pointer2_1_element*
>> +tpm2_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
>> +{
>> +    struct txt_heap_ext_data_element *ext_elem;
>> +
>> +    /* The extended element array as at the end of this table */
>> +    ext_elem = (struct txt_heap_ext_data_element *)
>> +        ((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
>> +
>> +    while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
>> +        if (ext_elem->type ==
>> +            TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
>> +            return (struct txt_heap_event_log_pointer2_1_element *)
>> +                ((u8 *)ext_elem +
>> +                    sizeof(struct txt_heap_ext_data_element));
> 
> indentation can be better here

Ack

> 
>> +        }
>> +        ext_elem =
>> +            (struct txt_heap_ext_data_element *)
>> +            ((u8 *)ext_elem + ext_elem->size);
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
> '

Was there an extra empty space here? I will check.

> '
>> +
>> +/*
>> + * External functions avalailable in mainline kernel.
> 
> typo  avalailable -> available

Ack

> 
>> + */
>> +void slaunch_setup_txt(void);
>> +void slaunch_fixup_jump_vector(void);
>> +u32 slaunch_get_flags(void);
>> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
>> +struct acpi_table_header *slaunch_get_dmar_table(struct 
>> acpi_table_header *dmar);
>> +void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +                     const char *msg, u64 error);
>> +void slaunch_finalize(int do_sexit);
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +    u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
> 
> extra ' ' after =

Ack will fix these.

> 
>> +
>> +    return (slaunch_get_flags() & mask) == mask;
>> +}
> 
> 
> Thanks,
> Alok
> 
Thanks
Ross


