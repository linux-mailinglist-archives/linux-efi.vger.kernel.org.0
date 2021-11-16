Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3954537E1
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhKPQoe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 11:44:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9726 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235700AbhKPQoa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 11:44:30 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFwsKx003966;
        Tue, 16 Nov 2021 16:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=lpNAwPAvrb3gNmt3LhOqEuUgD+3mg6r2bdGMCQkrsqI=;
 b=ar/dkJwYVq70wUFiIQp8poD9S1EMok9srGXIIymAFS1OxMo7R91B/Y3OxKB2CGz39EgV
 c1MjNR4yLYDoUAbqTBa0AgP1eT1JVMimWUMOo3vfYQ/tEflLy5WOkGiLiz1mwxLwYNx4
 aExpkUHfjob5D/aoE/xZizhpb5OqyAr5+s1PGvP6G2DwYs1VFJJY4QPZCUtqyctFx4J4
 H/aSpxpdcbC5e5xfw67qo3n3uhfrUdsiojs9tCSyYLb3y9IUAUOdsxOmrkw9eWRYqIZX
 wUrPZX19VP9Xc7iHpW367Z/jEGr5CVCNUCm3TvTV8agCCxiFmGxkYGHKl0qQfzutyX3f Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhtvst1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 16:39:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGGaRe6161961;
        Tue, 16 Nov 2021 16:39:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3030.oracle.com with ESMTP id 3ca2fwfh8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 16:39:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqVkEg+pR+ssLYvPk3caqMbX5tjV8Bncia90Hatjf/Rwo5iqplj+uQLCTCFSEqCBfLcnafKVGcVQgpILxKJd/J08TEd7tUkqzLJJ4Z/DHiQuTEG9C+efj9k2CiCvtDXgqv2Rs10XyrGuk5ujfXGAEsutRoxifwwQDb5bAlVz+2ix0kwam2uZ6cigRY5Wfu/jpd/91yftmB9YDye69V1K4G3doXRtVavlqfEZpwr8GqCb7cyNgt+3QiCeTQBMgIcS0Qi+AllGXOg1KJn5O9aDA9V9dn0/bbyEno7oX5ZBk2AWUP8GliZx2+V9TGzjpO76P117aR5PC1Gj2RnqZV6Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQc0imqH2b8gMYJ5X5OolVLUwBr8+xXk8BYRkNWiGJ0=;
 b=PQFrdF7TNQlSl8toBnT01NKHHaVdPb+60U6Cltphbvt22WCGkvaK0v4qIHIEIWDwsuCkGhW9/RS13UJJ14XFKl7HZ8VDP5cNbLM2Rhk7E6WRLVT5F+DhEnEAfAsivzI3oXMpnudbx64ifCcuAy4Oot7KLHI+jF696vSxJC1WSpduJA6ffHTgXrnI4YOyHg2/Z467CgORuGS1LUcuKNxGfExSo7xfmAX6AGDIn6ceCtvcR9nVFLNW9PgN0NSWS/TN7cy0xg0ScmsYV1a6YbNrcX791bp+uvhc7GrdoOtKJHy/xon9h1FOhXTtcgNjRVxohXmwghGQ8LQ7HGjmqzgp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQc0imqH2b8gMYJ5X5OolVLUwBr8+xXk8BYRkNWiGJ0=;
 b=cs0T2I0dgmzs7zLitdz5p7SOV8dU5S+m57MGcSDx1avuyLYZCZh2tZC9nY/0Ndm0AlNJa+ySpUY1zuwdZfT/0puyRzyMyp+uLYDL1mTcpQC/sxVI3L3DWTrwNggb+zQx900x/8VCt5ZfE6pEjSsQDYaJTqS50tD5oWkSa1fo95U=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Tue, 16 Nov
 2021 16:39:29 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8864:694a:8d0c:e79b]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8864:694a:8d0c:e79b%6]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 16:39:29 +0000
Date:   Tue, 16 Nov 2021 11:39:24 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com
Subject: Re: [PATCH v7 00/17] Enroll kernel keys thru MOK
Message-ID: <YZPevFtTucji7gIm@0xbeefdead.lan>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
 <YZPZww0bafYEQ0VS@0xbeefdead.lan>
 <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
X-ClientProxiedBy: MN2PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:208:e8::48) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from 0xbeefdead.lan (130.44.160.152) by MN2PR20CA0035.namprd20.prod.outlook.com (2603:10b6:208:e8::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Tue, 16 Nov 2021 16:39:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08edf729-6a94-4dfc-5bb0-08d9a91fa90b
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550FCC365DC59821F03532F89999@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8Sa4nmMQyvZZrkrgfeVQQAucJzdpQQOu8nfiME/OnatAAHJ3LXB+Wdi++31kpuzF3fLQHzb85+yIhyB0kshe+RT5sPJO7KxVRnDQbtLy+h9lH9bkCeKxIFGmjbqbypAuBRJZF2ULjSQ9uHMQH8xn75sbdy+t/U5VuZ/zAU2RXykp44ofDu04Rq4/r/0H/awx8b1mSy7laQBVKioRZut0Kjsfnts+hAIj+pAgnPt7Dil7m1TvKmRP0rjwPp6hF5pCvkOAxKpMqpcEQj7ch6nZmrPxq9ZHVKM4V3TL7kCR94hGDhREtsp4GKLrvLw0kW9KNR3eH48QxjeLf9L77ph9O55HxRk2Ag0YMQX9UcKQ9R0YORd1IfIm56eFzFnCFiFnPtmd2WKdr3xSzj/oSwI0ThX6/Or/9qlDqvcVj8jf1T4Evrnv58l7/x1+syjHvFTpw/WW8kF6/Vc/WFRDzVesH7y9PgJsYcNwPI+4AwIvZf/Zf/6nd1Y7+KCJQVOS5Cdi6V4el2qvCF7E1C3MoMoPVm+MSZSKRF5lmHBPuKWltaI8elYIKLKE6OK6yG/3LPuZjEYySc5OP/skROrf5azZLGuEch4V8jZyH3qmoJjCvVDGI5SOAuqJEgonokaGqM6dmujE/qX0tLDIrEdLGLCHBFPs3RF+oOSs3fXyakE1LO84O6wATLK81wvKuHfIsoTsb6iRpzMLT4Z3wLv/lDmydDBHpWKbxz0cFX9TegOJKI1W4CH5QrgiBJEbVRVPwb9uFJUPNrhKgcDfvQeal4O4i9U6FodFuFBuBFyE+Nv2AUUCSvPJrGSGA7F9cH1JFOjqckq0M+q0vIrXRTktnIcAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(8886007)(966005)(66556008)(66946007)(9686003)(186003)(52116002)(508600001)(26005)(66476007)(8676002)(83380400001)(5660300002)(6506007)(7696005)(36756003)(7416002)(8936002)(86362001)(6916009)(2906002)(956004)(4326008)(4001150100001)(316002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sUn1ThG2YR1qkVUcGiSsVGkXiZ3pMbjU+irHatWctxTxFiUboe+v4XhnCq?=
 =?iso-8859-1?Q?ImKvxil8Q/NdT9+7fQl65e0ttCmhbHqogL6+OClag+e93njUaurkIoul/r?=
 =?iso-8859-1?Q?+PjHDitZiu04NtY35TSKBtVN/I03qCDfCsOPRwFeEWOKbnUl7Z5LIrLUdQ?=
 =?iso-8859-1?Q?xTGTBbrEA8TKVq1BTVD+w/PQhqhcMAt8Up+PPrZ0aReH3FNNdvUbbKWjt0?=
 =?iso-8859-1?Q?uq1c0oa2D3BVzJkq+e14nqgVbZgoM+62Ww+GRkgx7kIYF1/VTRoymZMGMF?=
 =?iso-8859-1?Q?tt7D7fynXHl8HRMgUjXV7yxHMo6vwCT0wel1nKZJoJ5VxnwiCEwKoxas5o?=
 =?iso-8859-1?Q?edrfYYO0spjYVJbiiEZVPn5lMlaYFt0a8kUpjxaaqieKj7/jI/lo43wDlY?=
 =?iso-8859-1?Q?YvolnYuENYhSNHlO1kqomu4h4X9ayMwYLy4pCAUYcbhk9OzY24F7/B1IQm?=
 =?iso-8859-1?Q?AUFmdz4Jdgwp7dzjh4Ogp7q3wHXvnAU9jsQFN000TpTumBvVwcbOsuakXP?=
 =?iso-8859-1?Q?Se0MuNQMvEi2ksYnQfkqX2m7h7eVSlwbzTD36+qwJcKTV4NKug/evD7rPa?=
 =?iso-8859-1?Q?2s2L+5hVnOYZLOzYZKlsFi/+OuRBppE77N895LylRLIC4IPn0jFmm8SnKt?=
 =?iso-8859-1?Q?ToReDBM5Kr5OKkaemRWeLOxSOn5Zpu5EVDLe/XdsWIrw08k4K+LA8Trfc0?=
 =?iso-8859-1?Q?f8/Tw3deCUKVDs7BYC4IhjgGNV43eGK0FqeP5nHzqn+Yj699LJrPNa8q8z?=
 =?iso-8859-1?Q?20OKUaBFhGNHRby2URynb4ewsDqyz7I7xNAsTCk7W/mJQcRHglkS/f9Bic?=
 =?iso-8859-1?Q?HJJIK4iaP/QOcdknrRT278Zq6MB0B6zDrQyfPROSnDp9OFySifnVgWBTr/?=
 =?iso-8859-1?Q?4plj96+m/ddVr7OpFLvmvp1+kztgKCLZC7922gUGs0+z9rra+e8zA1XAcm?=
 =?iso-8859-1?Q?lIjf5bObAKX2ADkVqkfMJaayCSKHEPAV+ovsBPT/F46gbreRwnyj2pUQKA?=
 =?iso-8859-1?Q?fhShVzBbYHvmea91QOXbzFMNEDz3Skj9AOtRNg6bVakDF+AgTayi+K+h7m?=
 =?iso-8859-1?Q?s6fFDwKFZm7H0o/YC7qzYdNxKs9h4ImWjAvpsGf9dJGD6ngH2U1cYMnPdy?=
 =?iso-8859-1?Q?PS5VAYbBYxEbMETa1xKc3HSTllE4g7DNEoM7f66/ru/5Z1pIN6PRbB1B2j?=
 =?iso-8859-1?Q?upgLDZLSDR9nCd1n/VIprEAMjGL89RkZoID5jAbDz25sMNASgExDW0M5sW?=
 =?iso-8859-1?Q?emGtR+xW7QSnUFEXFcKCiQWynAxsRF3U+vUF+l9M7A+BOKH4yG05ooBW4r?=
 =?iso-8859-1?Q?/hwwFHp4K6YUwO5+2xXvcisNr+e1rN0DXt2xlVeDKgUm9+qfldwACQi72x?=
 =?iso-8859-1?Q?Z6N1qsbRW4jUHqP5egvmheB0/Kv3Pc2y84Do1C+Rd+l8hR1i7ZmPsLUmWY?=
 =?iso-8859-1?Q?NjuL60ZBLYtZAvyBOFTPzjd8wfiOjbZpI++lnyDo0PlKlrbWTyA/zQKYSi?=
 =?iso-8859-1?Q?fxN2chCB9eE8/eLddYtlqN3SYU49DcYKiPTRCMNFNo0hvzDp/O3s7M3z2S?=
 =?iso-8859-1?Q?8o3QJkKJKbn7tgWTReRE4Ckr/CIXv83vQ+ry2MrJQA4eBfwjsHgDYTta6w?=
 =?iso-8859-1?Q?8zw7dJyxvpjjqFNT6jPGxh+ds4nCFcU2XSXRoptQBiBvczocO5oIUKr+S4?=
 =?iso-8859-1?Q?nEMqXx5pGwSNfnaI2Tw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08edf729-6a94-4dfc-5bb0-08d9a91fa90b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 16:39:29.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6jGHsNJ3pB/pHA3oeAcpWnqVvSm0d4MAPxVP7A2yhBgmw2fQYU1Rjj/JhzpR3yj6b2Y4NNYXyHhJZCL0pZUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160081
X-Proofpoint-GUID: hpL1kOHnWMDY51qD62eYWTs_LH1St5Vb
X-Proofpoint-ORIG-GUID: hpL1kOHnWMDY51qD62eYWTs_LH1St5Vb
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 16, 2021 at 06:24:52PM +0200, Jarkko Sakkinen wrote:
> On Tue, 2021-11-16 at 11:18 -0500, Konrad Rzeszutek Wilk wrote:
> > > > I have included  a link to the mokutil [5] changes I have made to support 
> > > > this new functionality.  The shim changes have now been accepted
> > > > upstream [6].
> > 
> > ..snip..
> > > > [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f
> > 
> > ..snip..
> > > 
> > > Does shim have the necessary features in a release?
> > 
> > Hi!
> > 
> > It has been accepted in the upstream shim. If you are looking
> > for a distribution having rolled out a shim with this feature (so signed
> > by MSF) I fear that distributions are not that fast with shim releases.
> > 
> > Also these:
> > https://github.com/rhboot/shim/pulls
> > https://github.com/rhboot/shim/issues
> > 
> > do mean some extra work would need to go in before an official
> > release is cut.
> > 
> > Hope this helps?
> 
> Yes. I'll hold with this up until there is an official release. Thank you.

Not sure I understand - but what are the concerns you have with shim
code that has been accepted?

