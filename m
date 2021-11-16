Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4994845372A
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 17:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhKPQWL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 11:22:11 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14596 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhKPQWI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 11:22:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFM7H0013973;
        Tue, 16 Nov 2021 16:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=DgH/QGA/L4mlUVk6nxn15OVDIpVotrnifxBsgJGIw+g=;
 b=FiIS8Km3uOqGgxrRTeOwzyT6pZy4PiHLtbSLxyYzv/185gCm+4OnNJmXcxT3cjn7ccsN
 847unRnGp/fWQf+mRml9S/gYs30OYPssHEV3n3Zeq+48Gdpn1yK4svlszftaMi2fZfpP
 z3O1IZya4qw5wvb4FSG8/jrn0GGn/XB1a9g6K4ktcgWwBlK+LpX7YLbtBsT2hZkei7Uj
 dKIHeTbS+Ub+xSJbRE8r8uWfVL0rU/vdkp419UJQsIgiIkVPnAlbDpK5gv8WtD63lvH0
 0yBF7ciXOC5MqF+IY/CN8YmAe/UShUq1lvMQmTTgCgky0qJqPkPxRAhMju3Q9zAswP1e Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv5ak30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 16:18:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGGGO1c161561;
        Tue, 16 Nov 2021 16:18:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by aserp3030.oracle.com with ESMTP id 3ccccntt7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 16:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUuRytBEaRJdEz+4Cnqh14kxRyGs3OFw7wBzo2UYpfIEwNLYKcl7LyehjzcfT0SASUc2SbVKvAQh1dwqWSWhLZ/09JZ6jc5pzAHHlcLPywKDkbe5Ncr0JM8BZqnDjsNPEOd+2GC13Q8JIvRHcwWn+q30b+x7h7ifRDWE5aOf5xtFF4qLKBMCIMO0ZdTjNUrvOC6JvB7TgMu1kPIiPRN0KKA5ZWGl7h1j/PtkU6nieqtW+NZ2F/8Ih81AcNExEgT1kSGR2NPkruc3apjExBiRwWsNTF4LFcoyxKI1yQaCay7csqyFmeELQk7NCnh62MKgmzTgoSPtcsOWjCQzDHTshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn6a+vebsqS2I2IZ4jd/0YSXedRvmLAFzKvqm1YhnFE=;
 b=daAr/TPowNyySFpyW4tt1/BffWg2Cpps5NA7m9i9KYQ/v8IAZ1fo82fujG5TK3cpukzxATnb2+AH6MdZa3yFnKWYuBAmCdm7/g6NMv10vCxA9Y7DmrOc36I9QIh8FuuON4AkpmC1sSXhDUfNOOVqezeLKg3Sy5WE8WT7JJiXCQcdgz4c0XYhWbSjxbBg7WeqDgYk9r61FjTUiArkTNtGuefJ74fRWWMhmoDezv2RQ7fOFdiERxKh9/q8RDhzZIsiG7+9MOwqi01rpB4XrsdD/DtG1Ur2Y5HxaqjXl0TihaSsgSrEwGujnx36776lzjxcm0mAKpiEnNpkcbw6raG4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn6a+vebsqS2I2IZ4jd/0YSXedRvmLAFzKvqm1YhnFE=;
 b=fzeapLN7OI2YQJevwUNFiUIzRhkbFOsiL1OSBofCurJv0Sd2bqYoaj6bZmIQzJBURJyGyRkuGVTDlCQ+rA1Su9PDGHOUj9T9OA5tuzts7OIpVjKfeVzpCXYuVa77jDKCRhnH2vZG36A4KWOXMP1zq1T///bBQP41NfQrW1o3h0Q=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB5768.namprd10.prod.outlook.com (2603:10b6:a03:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 16:18:17 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8864:694a:8d0c:e79b]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8864:694a:8d0c:e79b%6]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 16:18:17 +0000
Date:   Tue, 16 Nov 2021 11:18:11 -0500
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
Message-ID: <YZPZww0bafYEQ0VS@0xbeefdead.lan>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
X-ClientProxiedBy: BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::25) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from 0xbeefdead.lan (130.44.160.152) by BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 16:18:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b113d4-f11f-4097-bd82-08d9a91cb2d1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5768:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB57685BBCA565646A7E98331A89999@SJ0PR10MB5768.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMfdJjGEkyzC2pWHS9ISNx8oZgw1FalFR1DUUlrCy8ODUBt51OsAAOP1KnhJ81q03rAXSyUxZjgH8w/l4DLpe83I046R6EBXc9vka74yl4viuiNxUHBJuvCh29mqf3cVU+T4rbubodR65RGFgpQ5b2GBHxujhbRelwK4oCJsh+AgV1r31144VINqR5J6E9ddMjIGukkUGNCEtPAg5ZUIotrEXjh7FGY5p+O+gCC6p55Qh2jH5b9QM2o2KS4TVmnoJ8Hx5uXXVKMFa9Ib63ygSZ0CyfMIyU2jHvA6pNjKn4FGpwCv1o0CEejHIXe2HujtuZQnYXWz9EQ8kmmp6Foo1f2uYSN36skYUYipsSxqMAwjTH+KHbkLXA4ovog/pjroV3PySGw02eV4jjqpMGYcfPj0CtR3hPn8dKRV3vvvp5jDaBLWaIIOjgl8kD3haG+bY4WUjC2R6+wQj0VCcJ6vOZgXlAxifWjXzYq02q6ZgG6TETQIOHOHKVrF+BcCHP/jsUmWZ10PYne9RZ8xX6miKJl6u4CPVIF8FTt1l9ayMCWJFjGhbtRBoFbfpIz41ClD7rYXzWHJ+PyeA/Gpx9RArSPF9H70W6zSlmIuyFPDThf7A2xwiMONZjM4CMPK1rLI51Js5b2hH3u5FZOYh2uafuz2sQbhHplaAakR9DhFSot0or42dM3cniCKzk2NLxsHDR66dYuCTfDeswAOJDlyu7mHWc2VM79Y+e4iC9wtJtTUDFamrJZH1ii3Mxko3jwlBdUyvk2UYFgran/VR2vtdaDNUR0CcXFSwMfbU/8SRP0ADsMCoMYI37UA9gQnDEphW6hXGL6HA75o1L0Ed4MP8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(55016002)(8676002)(508600001)(36756003)(86362001)(66476007)(8936002)(66556008)(66946007)(7416002)(38350700002)(316002)(6916009)(38100700002)(7696005)(2906002)(5660300002)(52116002)(6506007)(4744005)(4326008)(6666004)(8886007)(186003)(956004)(966005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GdSQEBgmaTuPosuu2QZBOLLhUv+0vN5Z+v/g2rYupfKIpg5lJNbZdl3N0g?=
 =?iso-8859-1?Q?GHitOeWooC+9d+U5kKjaHfkBuqR8h0pDWOaLPWqaJiMo1WKd0xqog4j1+0?=
 =?iso-8859-1?Q?grvx6ORd4KrxGP5NRfbjxBwvfvvBFeKQSYGUiNbF6S4AXsgOq+QWwKflW4?=
 =?iso-8859-1?Q?48JMW5dyDdEW294ylg6qyoJQE+o5Gy+dQXlBH3FY2gMrLNYe7Ge5OH+Cbj?=
 =?iso-8859-1?Q?TB2JVSopl5WjAczodc4uKMCYt7vbbo9d0+rP+W/8FSHvRagyRCuoR+4f8u?=
 =?iso-8859-1?Q?VjVmUY/fD5LHqSrIlEmMraDz6yY+8wXvAs0Eql02ksGpQwbqRY/uAARGS1?=
 =?iso-8859-1?Q?Bx83glkblWKnQ+uhPdOzNyW34UGQTv483wdtPWhVuh1qPvvGyTiy3crxqb?=
 =?iso-8859-1?Q?xODNjBUusqj3q4Uh2KLSYXdDRxM6clOrMiljC4MoOYVBltcB5p2GzyCS+y?=
 =?iso-8859-1?Q?xKjB6vj4yXfhcpQbFaWcVMUHZ5Q7cOcQ5cyk8FO/LzXg1mx2whTN9B4zfn?=
 =?iso-8859-1?Q?+QHrHZ0R0C4ZBVGOI4QOfxY74YlZPPhs4+1SABNTyobyzY/8J8f//jB9MH?=
 =?iso-8859-1?Q?Ugq7FD1Adh/qTRmOss8MAsRnvsf0l/IbHhOufjsGXQyogF7fO0x3PmcFM1?=
 =?iso-8859-1?Q?mZCR/cpo5CLAd7gY6Ls5eMjWrAQPA17VQSEU8I8nzMjJgcQ4ECrhe71zba?=
 =?iso-8859-1?Q?PBQukd49CafzhUnnAwIWisrYphgB+XCWz7aY7z33dME5DCIveSZ9sVlIzG?=
 =?iso-8859-1?Q?UwxM0MpidoUiyqVGQ4dO4FhmI1yasWjDRG9GaMFSLUemQ6uPJrKmbgNCYw?=
 =?iso-8859-1?Q?XEm9PWNdShHL3c4Ge54kCC1evIjnbSdlFXKbDa4RKbHnqRvINYAv6fJUT0?=
 =?iso-8859-1?Q?JSgIwjs2Ai/Ig1177YQ+17MV2NgTGtV0hrGrvPH3oggYV9Vv42IHzY/sEe?=
 =?iso-8859-1?Q?O5Af8qe8HEXnT88rSPSK5K2qQXG/3chvSv2UdCWAZZj+l1hZuDoJgu/k/I?=
 =?iso-8859-1?Q?oCIp72AeeUSeZfAYIRv4AUs2rjohwYrMcLH3SLgngCTOqQ8Q25/Ss4iHfZ?=
 =?iso-8859-1?Q?Spe14YEAGIxMKIPQHPw7nZu/PXGHEV3QbVD1mNgZT/TxzgWkGC+s/ekSTf?=
 =?iso-8859-1?Q?gotp6olJa1XpWLIEjUdLYuuOS8Iqn72p5FgTxRuH4Lvh8YmXd+BLKXC1X/?=
 =?iso-8859-1?Q?WhAM9qzq3imsEpOpxuZC4T+ht2bkEU+Qd3gAw1gMO5P7FobI/Z72TSewFB?=
 =?iso-8859-1?Q?IP08u2mprHQwMZ3fX2MCvCsbs8Tci0xHBvL9PVsxrbO/M5peqFDx+Xk0e+?=
 =?iso-8859-1?Q?akw6RW5ZSoK5tYFsi6czPzwnvbKgQgvkoc5wxoAWeF9JFLwbjOuoCf9rqG?=
 =?iso-8859-1?Q?sj5KMK2w4sjvP440tSzuLz80a9FCOB1gEuWomSkI56OaF4DjUkYvH9ixN4?=
 =?iso-8859-1?Q?zrGrQOniniQ4X49ZBy98xmuS0XxL2s0fzxPDwoJ759ZaPpDQ0Ozbi+7dbW?=
 =?iso-8859-1?Q?uct0OvlySabdVP5xajDZyIS3s/JTLdk25yhfDNQMrWiEzznAyb2G9vwlhr?=
 =?iso-8859-1?Q?0YET4k48sYFPi1mrl+Y5R8SAL3/F6IRqzY85cYMF7ihSvdjjhS5LvqF5Pl?=
 =?iso-8859-1?Q?3KwxPKXGKCaM2QYX9p7xm4N8qgBERilXQrAgjlWcmgYBhB/08cpjR2phZT?=
 =?iso-8859-1?Q?GQzG+fA8q7AiSlegBBM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b113d4-f11f-4097-bd82-08d9a91cb2d1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 16:18:17.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgVM82shlwnyA3sUuPBJvrS6+7N2Jt0PyaWnATi65QeIqPErLKYqm8GluTbIsMDOBtpT2iy5Mba5c8tvvdN7RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160080
X-Proofpoint-ORIG-GUID: mWbuZi19kbJfRAJ1wpyCV6NAkyttnbN2
X-Proofpoint-GUID: mWbuZi19kbJfRAJ1wpyCV6NAkyttnbN2
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > I have included  a link to the mokutil [5] changes I have made to support 
> > this new functionality.  The shim changes have now been accepted
> > upstream [6].

..snip..
> > [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f

..snip..
> 
> Does shim have the necessary features in a release?

Hi!

It has been accepted in the upstream shim. If you are looking
for a distribution having rolled out a shim with this feature (so signed
by MSF) I fear that distributions are not that fast with shim releases.

Also these:
https://github.com/rhboot/shim/pulls
https://github.com/rhboot/shim/issues

do mean some extra work would need to go in before an official
release is cut.

Hope this helps?
