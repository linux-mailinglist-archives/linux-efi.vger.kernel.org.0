Return-Path: <linux-efi+bounces-560-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0328560AE
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55874281C6C
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB2213174F;
	Thu, 15 Feb 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MxA9Wv+l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SRh6mLPL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A8127B6D;
	Thu, 15 Feb 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994616; cv=fail; b=UN9zl6ZowK8+WLcz757uSNW9IafpykMhEgF448K0q08twg6NMhURIqKqSn3M/odE/5yBPte2Q5iq2YaEmOUBv6zTjpKLKP/G16Cu7EsZbM/nRpoGeA0WObJOqW7zpo1fFnScxwXEUx6I71d3wwziUVxWSeYXDKXOzBE6k1C0nnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994616; c=relaxed/simple;
	bh=yPCpBZe+BJNcNa7L7yBGygG2Uy/ySl+05MojNia3pRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KQK8BtHXdKlAEBRJrMy7xv8CAkrq9fOesUZkVhDjLkIvzvcrw1nYdBZtQSjeFpu8n3k7bKAyIADnsXuZrnHxVGbhucRuExt6sD4ywLwdP8VszuSS+BZJTEFbdbU7ESXCe70hecqEboJnFf7w2fn4W9D/Mtn4q9hlOAwdO5v7ji0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MxA9Wv+l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SRh6mLPL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6ixB0000670;
	Thu, 15 Feb 2024 10:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=yPCpBZe+BJNcNa7L7yBGygG2Uy/ySl+05MojNia3pRY=;
 b=MxA9Wv+l7gmCcUGJFsjZs8bm5r47iLJvo+GIshrOABT1lbuneLfhJpXjRa2qHtWDH2MR
 neFB/E0lOu/wtdDlwn4CNj+yigPJ6encW43NHdrmbx1onwQHk7MK8jW+C200PGZrPjNY
 IECX+wk0uKpLhI7oX4zCx2lQLkxsd4A06dKm5o5JxhzbKWYdKeGjaPiq1HVqqT9Vaqe7
 ViUSxoYHZQgexaqFSS1AIJQ/CuimP4ID5AAEl+DNkl2DILmrT4JCfNuDP384jFzuX4dd
 EHeLHe//Mym4YehViLK0Fk+U7Qf9To+nj37wd+E9ezy4G5fGTyFiX8KFYs6i2WNhSfxe og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6swkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:56:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FAS3uE024589;
	Thu, 15 Feb 2024 10:56:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykgmn3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 10:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3m0FsfS9xmYML/ZElm0AuejRKCzXurLdiid6DGXj4REhExu51sP2uWwXLsqkcg81u9Pt7NMIaeClwVZIsREODoVm7076g2waNM6KBwd1mmdSqsX751iStNHILSbYKOL8ocppwm/hAJsVQ7mpWtjZxUjzlMgOse+JnBQxIZ4lxLJLff3eT5gwspgPg9PEMBNkcp3rudjt3n2D0Ca6QuGf03juxBu3Qfpkm1xQ28CNC+FSdSR8dcZoSPPhhJSFkzbL+vcJ++Y4+mX3WH6Hn/tbB/5Q3E63ygVYyXnKooTtpXBcc4zYMiQzHXRqqwF2KFIl4UB9ZBxPcMB51ABIpPDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPCpBZe+BJNcNa7L7yBGygG2Uy/ySl+05MojNia3pRY=;
 b=dEAHP5DUJHFslMjc3Gbc906C2vsg1ZOTmBe7IcapL+eRHaSaAMniGXshUBiqN/8vsvnx8thxsrGDSQ6mIIENNptnAXvryM6QChGSFqis4w7/n6ybPzbTUwAfiniC7ulpOwBU59Z14lJPGFbo0cVuxSDvBYn23jW/iPe1OsJylsL5Zt43NKNUQx3PiILecGa/70uVRYZPYPc0tUsU4lmRL+kD4R6mfUD9peeCz3jStfLjAl9sViPHV0MMcNwxgqt19nMJVWG7tj45rZVs7s3WqPTLO5f+kLu9nRI6sEvl4a8/u30i1iYoPewoA25qk0H+S0oEKOaw9WD9kSLDtfEN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPCpBZe+BJNcNa7L7yBGygG2Uy/ySl+05MojNia3pRY=;
 b=SRh6mLPLac4UDEP+BUewDz/Hvx7enBNvOuDvnarS8A4JVOL1OO0fyNV/ks8NZvDT9/BLalbfWgu875A621eyh7fShVpUc0nCD+v7+KxT1HGRixfacsSmgvgOeroYbnyF2BACCl6RHRtTUqvXJUQuE0PTJ3moQ1WWipbHWSK9apg=
Received: from LV8PR10MB7920.namprd10.prod.outlook.com (2603:10b6:408:1fd::10)
 by BLAPR10MB5170.namprd10.prod.outlook.com (2603:10b6:208:321::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 10:56:17 +0000
Received: from LV8PR10MB7920.namprd10.prod.outlook.com
 ([fe80::bdae:43a4:670c:48d1]) by LV8PR10MB7920.namprd10.prod.outlook.com
 ([fe80::bdae:43a4:670c:48d1%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 10:56:17 +0000
Date: Thu, 15 Feb 2024 11:56:10 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
Message-ID: <Zc3tykqH2SjSVtd1@tomti.i.net-space.pl>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com>
 <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To LV8PR10MB7920.namprd10.prod.outlook.com
 (2603:10b6:408:1fd::10)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7920:EE_|BLAPR10MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: f1eeb0ab-d3e0-4943-6049-08dc2e14bc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rWSEJNDZidz3rrVjKErilHVErG0u96tcwBAaV+sOutnxY/a7Fk1KD35IYpTb79HH8dHligjMh95GOPHYyMm0Vds5AdjGCy/K8KnTp8GpesF1AUFoCAUWXMF99Gpj+lXQLpvbSX3s2OUdcy3IlEbrT18l2wXdDJ9Olgabm3ds02bD8w2/gASBj77tJ3dYiZCZ/fHhNjH0x6c6Npc0cgQXBF1PyeoaybcK2yhpE90xh5QCm3Vwt5pI4KMl9t+nX/6PzjkmlQTj0YqlRFGd9HOYsUwb/VsYWpP9gQQWkx08VUe7PYcsoGBt+CFNAJXQ9Bdo+xdOb7sjkw3ugqSTHs2/Upx4SZB3DM4zZN7Rxpc8ZPsg442PKA3PZYMZeuLWFTmlxl7ZvzvhQT3eEazyw2EvuXUzcgZFhIJ3yZof4bZSajTKDTTeZ2br0iS8vkgcSNXBK8pLFA5fTb3KzUFC0YXb6dD3lP7J7QOMlW3+f1pIo0LTMGv9JUekhV/Gn/QDLZmCVYMoou66/Co9O2VdNXZKqsBDCkjbF+uRlTsk39vKQCu16wnnYKrDxzbQZI4jC/mW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7920.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(44832011)(66556008)(7416002)(5660300002)(66946007)(4326008)(8936002)(8676002)(6916009)(66476007)(2906002)(26005)(86362001)(38100700002)(316002)(6666004)(478600001)(9686003)(6506007)(6486002)(6512007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ulL8RWxye+EK5/EQRSOpLvVF7pq+eNXstB4Xm9qON0CHR8D3RcPjV/NDzuQC?=
 =?us-ascii?Q?vGaF9o7wLy1YyIM/X+KHUSOvYaxVazu6uQDMusyPyAqY9KZk8u98ffUOtZnm?=
 =?us-ascii?Q?p/dPJfppLWrDt/m7N2X5A+VtJ3P5NUblLA1j3fuYqLKBn2oOe8gQQ7nAabVW?=
 =?us-ascii?Q?TAj8ymt4CtY3P/CgoSjY1bKRAH2qH5CUplrEc2u6ogo4DHSgF5SEP5Ydcsbd?=
 =?us-ascii?Q?bPKJAQaFcbZx+4tpEXtrAYkbxN610qQHjVrSPMr3pXpRRxOxjx2+0MqUYwQz?=
 =?us-ascii?Q?z6XP9X+f/X9ccnBYyNAqXWATglDjzsMyUWac++isyZemHCeCDn1HiJghmo4r?=
 =?us-ascii?Q?Rw8+7mQqMLgRxN1tfYAHNJeuNgj5odPJmBneprYRWURnLmr/FAUQTuMV9Q8f?=
 =?us-ascii?Q?5sq3oxfvzEOwkZ3wWXP0bikKMWgdUh2pi8dC5plrIbiPMW+/eL6W0sS7iuFi?=
 =?us-ascii?Q?Ll68NPjLmtx7yIvIA/PwNzHWlRkyv1KqKnzbGDKqQhcsTPdSu7FDdpaM2YDh?=
 =?us-ascii?Q?D0EpPBiSalGv6YQw+0X82Seam2P+IUJHkMHx1wqXlYKnmgIAoYPd2drVTL7x?=
 =?us-ascii?Q?gZFo17fhzyf7lqT4TWQgGbjydXU4H4AAdNehdDIbW9+uRcgDBWvbR3jDRY2o?=
 =?us-ascii?Q?YalQPPvKPdgOoFeDI9T2PfnIwhIfwuQaGw6xeUubeCtWYsNbfo3x6O96ibTy?=
 =?us-ascii?Q?o6NodA/KV+i8QIC4zbLg+8OAoonGqt3TLiLz6tjVXsFwpb8/Tot606GaoWsJ?=
 =?us-ascii?Q?P/ydjMjL8uy+85uV3zCUK+nM2BAZM5YeVNFZ5Ume1OHCwZy8JbNU0UZKYbMG?=
 =?us-ascii?Q?PBeXlvpyKZ5WJt5NCsbIbVqm/72jr0XSEjNROWD/uthrQm1CN5BbUNYc/ure?=
 =?us-ascii?Q?CgTMHTClbo+w8jHIo5MAxsdJrvt+oB7zWulG+Dhcm0+iPbxqcsTUN7Iz954b?=
 =?us-ascii?Q?bNme5nC5OH9M7CITkuBHTsSyzxPfBWNCGH8aaZJDBrPobC1X8O++OsId7Dot?=
 =?us-ascii?Q?KmdYZ9LeTCWiRhFWHJAD0V2mxiAwBxegItk4RuakRP02iaotSbvCY61EJ3nM?=
 =?us-ascii?Q?G3z8h5pRM9NRXWy4CXuWqvwT6sk3VBwt8fBLDyWcQfcJW2VTNkQZ3fTDZPeN?=
 =?us-ascii?Q?1iaoR4PAkgzPjU1uDMqebPaIBaghYQCpkWsHognii9JQoUFiiqz5vup8oiWo?=
 =?us-ascii?Q?aqXxDdwjNHayZSIiFQdNhlVPRSo6r+s1Qwyhg5YxlTx45qcJg4zfqIOp/SSD?=
 =?us-ascii?Q?OS6ZnhyJSj9TLSY34CWWsbIUDsTY+joOR9dz/1ey2y5IazU+fLro1JOFL0gh?=
 =?us-ascii?Q?71OhybIujGlAK74Otjk2qg76lA+SgF1gg8wxzBM7SyG0IIu84/YE9TCC9NH5?=
 =?us-ascii?Q?29e34CHdU/nk2LrvgGjZvkvvtrB7tuxKHcGvbck74apV1Zq4WCmr9mr19dun?=
 =?us-ascii?Q?XPxz2rU36iPWa7zZxIa3G4gSBYnmyf86JvIV0Dg4h7xYtEReMgVc7wSrSW7h?=
 =?us-ascii?Q?dG9cjfHtdDWenoJrgRTz7eTj7aucHnb7axr2vLiMe2gvb+oL+SNxT7/ryux9?=
 =?us-ascii?Q?CPPHK8fDC/t7HOaFFGsd8z2D+8s5O+CyZpUblNeo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	99C1mulkHQ/qVS+nRitFJgw8BXbvZZLYFfu5Y800QvtMEOjfzKSJHY/1rl3Ajs7e80PWhZ0l0DldZGrqO8zXF8cw/N19ThPfOVBGDT+HPJX84n/wN3HAxX63fI32ycrkEHk/NK7+57+kwBbUdT/R44WYPudZ3Ek1Mv27ojK7XRY9g2blffT5+oFTKAg+/7ReHjuTCmcbcz2Fx+Tejj1oNdvZ2lO5DJ5QWbZI+vko6+PBAGcN1rcDjBdQW6nBQ/82CCxpq0XzPzMhvVyQ3h/OZaDFrLoJydgMserep6xNyH+cehqktDkeIX0tM1fskry0vrjBrpMa9yqDbd38gNYh4ETinbrboFCn2SUMFnbdDT2hk0hvrZWA+TUgQyppniLi2nvq/tAvRMSF7v7sfVDud+4bOHdgLz1oeHTS1gddu57q0mj7FEXwEv7USvFh1l7YByvZaL9dZKdSZS/DQvNmuGhuJk5lr6kp8y+LqUAJLs0GzPHkXS483iZrpsx0ZqG63ACGtqmrTMryuVhP8s5kDY7ZTzwC9tAFyiuk1w+5Z+heaqitGdVYUVKTPPuzsta0ruKxsTTwEWPs8zzNIEHwmOLsJnBA1ZndKPJD6k71UFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eeb0ab-d3e0-4943-6049-08dc2e14bc8a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7920.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 10:56:17.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoUUkDPLR2vRZVDkv3SSTD7TazsJZNA2PewqJWcgndsXmZnY7ITwPRib/E3Q5ckTv8ojVrdIqiyNMtJKN0z8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150086
X-Proofpoint-ORIG-GUID: v7A_Mx55t8SU1ekVojVwFesSvbiSAqhC
X-Proofpoint-GUID: v7A_Mx55t8SU1ekVojVwFesSvbiSAqhC

On Thu, Feb 15, 2024 at 08:56:25AM +0100, Ard Biesheuvel wrote:
> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
> >
> > From: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > There are use cases for storing the offset of a symbol in kernel_info.
> > For example, the trenchboot series [0] needs to store the offset of the
> > Measured Launch Environment header in kernel_info.
> >
>
> Why? Is this information consumed by the bootloader?

The bootloader stuffs this info, plus some offset IIRC, into special structure
and finally it is consumed by SINIT ACM after GETSEC[SENTER] call.

Sadly this data is Intel specific and it is even not compatible with AMD.
So, if I am not mistaken, we will need additional member for the AMD in
the kernel_info.

> I'd like to get away from x86 specific hacks for boot code and boot
> images, so I would like to explore if we can avoid kernel_info, or at
> least expose it in a generic way. We might just add a 32-bit offset
> somewhere in the first 64 bytes of the bootable image: this could
> co-exist with EFI bootable images, and can be implemented on arm64,
> RISC-V and LoongArch as well.

The other architectures may or may not have need for such data due to
differences in DRTM implementation. Anyway, whatever we do I want to
be sure the DRTM can be used on UEFI and non-UEFI platforms. So, I am
not entirely convinced the address/pointer to additional DRTM data
should be part of the MS-DOS and/or PE header. Though I am not against
building something generic shared among various architectures either.

Daniel

