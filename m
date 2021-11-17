Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE057454B8A
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 18:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhKQRGO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 12:06:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37124 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232277AbhKQRGO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 12:06:14 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHGxtBG032422;
        Wed, 17 Nov 2021 17:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=agM3QLO52S0cX7KJp/DoYaK1xfnK0ZfU9eqn6ptBhxU=;
 b=02kvPvn2WAcGb21hZE51kzpzpjMO2S6+FhMggLCeSusGswZa66pHS03ZFFYnCU/Sanxi
 BEN4BFgQ2jRWzd0nKs22Y76fnMXugWyoLeEg48atkNaXP7SEeeiyzQSGkcG9K4prs5aX
 Ws0lFv/cGlaZBb3QltWQi/yHgHNoucUlJcII3xnAzPZA5oq/k/pZEFtatRQ68XvWELXd
 2kehTjTM4mrqsYzQVJcfEeu7kKPHcKwlHoEPJAtmCktXw/b/592r4nVkya0mEh7iiMPZ
 JMTPd9dhdHuKqWSqN5CYqiQI8yM4SLyp52G5N7aLBnu2uVX4lsBfCYJ5AHHPYoU5wd+l /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd1w81xk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:02:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AHH1OJf147376;
        Wed, 17 Nov 2021 17:02:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3caq4uhr6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 17:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7S3K8K1TKPTjcZgXouewt37+gDz2gPWtLgZK/nLfF6c31SD9Rnk3e9YXdNYvgilS5Vv0boq/3m2Yml7vd/N5Ws3z0oNKid5+eKQ+C5TayodpfWxmbi++pEwc1Q2YTuiUEPr9o5aLEZexuEN/gy9HkxNWgurbypCDTC0DpR7AVlYjVsCoBHOp0/uhw5uvWLwildNuDhZD9dVAGyckvlzwa/3hZdBseBB8Q//iHARxObhMxI8D7jF6oLR8Y53ywz7MrF1Mf/HfF5KBPqdTILqBrSlSUFGqBdY6ONGbNx6WNVpsWCeB7sbvS1kOVypSNyrmMGoTMQ6kLd4QF493V5wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBWkcjtmmDSZduGvua8cLQeBODduGqfOAPJQlHMme4k=;
 b=YGdtzXFUHpNJNXjv0MZVj3Olkoo79AiL/TEOVw8Rxv5hYzQuZoECgY/qgYZOLzDkoME6QDcX1Zdh5Pq3VY/LZ+8Q9vFJ2X0X1Sfr8BceFW55c/JGykpU7RvkzVF+VaX7mDtn8sqXa/FETZxmKsgggUIVJSDMSn3jxNf4R+GRWPUl1a+2N2eE2LxfYuuA0SK83r+TK+w3xdXqVaB2m22I2JuWOiljWq2/VXhfFj1c6ubf5whxxW63ubf6EIGZV6Q+CjCaDGhg4DIyz3dswJPOLY9y9f3BZ48f9kLufOBVp8QlnvbqSdS6Tv2CL8aP23XkITx6CZCicSLDJyd3z/+tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBWkcjtmmDSZduGvua8cLQeBODduGqfOAPJQlHMme4k=;
 b=aplr6muT5d+1PRYT29YmlWbXQVa3OB7QH2gFVm5b4B0cohHAPynkJeI7uQmgI6qfPHJ2zNHEQ/c+9XKsH5AkmmIM54L4bXfZGmLyueDPisORTatlAqKSyUOl9FqpAt6gL3DAMg7DKhIdD1st7abPmVdJJIDrrmxztmAk7r8YINc=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3399.namprd10.prod.outlook.com (2603:10b6:a03:15b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 17:02:20 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8864:694a:8d0c:e79b]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8864:694a:8d0c:e79b%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 17:02:20 +0000
Date:   Wed, 17 Nov 2021 12:02:14 -0500
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
Message-ID: <YZU1lkBkphf73dF+@0xbeefdead.lan>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
 <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
 <YZPZww0bafYEQ0VS@0xbeefdead.lan>
 <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
 <YZPevFtTucji7gIm@0xbeefdead.lan>
 <8fcadcf2a5da5118fb7f9caea0a61440525a67b2.camel@kernel.org>
 <3939a2fac50d2e836c48855b1b00c7b36659f23f.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3939a2fac50d2e836c48855b1b00c7b36659f23f.camel@kernel.org>
X-ClientProxiedBy: BL1PR13CA0366.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::11) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from 0xbeefdead.lan (130.44.160.152) by BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.17 via Frontend Transport; Wed, 17 Nov 2021 17:02:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2c4d8e-cf70-4467-0cfa-08d9a9ec044f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3399:
X-Microsoft-Antispam-PRVS: <BYAPR10MB339904B64CDB6157C81B60E2899A9@BYAPR10MB3399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fn9cbi4sO26ms5F8kSrIaZpjTSzRpYxao8tWWeqknzIWCD/xYqkpw4fFrHa4X9yWm6TWrvSbKVaoSm/LxnoTXc+d4EhYj73kQ2evZH26gYzBVU1FrDwWJ5jEXHiyIiTbcOaT33De6TJJcQP+cTaJ12gB2cM1ivSSbnmnRPSzGdgjDfvQ6TlljyH0NqPvU9H6ha8SPmIGbIlT8K2oH+XrZhb0+FUX7BSSjf/BSv9qXAPHVRl/eIN/scRdUm+05Zwz6wdN8EAPom76N+jki2G5F+SQIRtTet7Qtwq6+rdtcPvOYoeKqqQ76oeFhTYFGf0SNp48fbeB+e3/Vh1NspdoVbushjY1+1B1DBgoNCH2IGTqI0RZ/z+o6XKnxkz3eV9gAYjl6AqEwtuFVRY+EToSwJ0TWOx04op6otDMPHxWOzV/IXhdSI++e8uQBxy2sSH5EKh/n5B1YFJ+FO9deFcZrB0pzoVNrmtis+HV/TiyZS5l+cg/Y0egU0LCHxKV9UQSYgRIKQPOHWzUZRI3cIYGbiJJwqGieYucVL6bEMXz13IdaG+8ZkygxB1V9s4STb1qGDF8Et5d/loSkR0gN1v8CwcORF/i21e6oXrnfAvkH6CqtYO7zLf1WcsAOxSyiraX4a3jQdstSFiG2Ldly+eW5xEpprVMIAjcit/sfkR+N8hz4mDoFomShVwWiswkmBuPybJKsPB0pWVzdK0XK0ez1Hisi5ZyGb8PyL3/Vq0EMAScIOYUDQSSfc5tY1WyxESw8G4pamR2VdkflXL7F9sYP8rRYuOkEQyC+TeHfsUj5qU2irYXz/uO1tlzGOS9qHacNlX0qsR48qrzHkAo5XV8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(186003)(956004)(8936002)(26005)(4001150100001)(7416002)(966005)(6916009)(316002)(6506007)(83380400001)(508600001)(8886007)(38100700002)(38350700002)(45080400002)(86362001)(8676002)(6666004)(2906002)(66476007)(5660300002)(66556008)(55016002)(36756003)(7696005)(52116002)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?S8Zgc18hbmlMga0rLBnt/+IWZI1I7hG6jF5jEkRhSpytoUlIbRr8oz0nRp?=
 =?iso-8859-1?Q?80iLlCtWdPZLWODJo9dDyeDnACsvV6wyFmOV9mlTGtV87E9aTv8TR3WiPh?=
 =?iso-8859-1?Q?Xg1fwty7I6ih6MOB/g3wPqrAR15dRP7VA2n7BxVQzEOowBEgdde1qogJ7+?=
 =?iso-8859-1?Q?vxg7Ne/FgiBAMR7TaWbEjScgmOxIDtOzFK6A+fHAxXH1cvrUO5b1U+b96h?=
 =?iso-8859-1?Q?TweteVC7JviKY3qVwZcOTD1gt1jU9kWmrmAx6b3+80WhuvIjE65SeUpz56?=
 =?iso-8859-1?Q?glWfTT8bzcXW34ZlSkQv/df5xw65HLbbW+TGtcWYnMH/I3rxp1nesWh5Fv?=
 =?iso-8859-1?Q?HFfo8xfEbiuo0SG51GD4rkE63gnhA6vuTgjhLdRKlDnU0EVDNpciufhNs3?=
 =?iso-8859-1?Q?ROdB5zXs1kDSMpuZtNqwSDaZfdBkD5ckHUGtM19YM/rhOp0n4GsW8NoyvH?=
 =?iso-8859-1?Q?5O96jsrr+sA2HU8fHIL/f0NOkfMKWbfSzuJugxHf3cHlphhsm4BMYAxKVE?=
 =?iso-8859-1?Q?rNCi97FIqZXtLmW1kSnWfvI0ar5XXqv5PswbfykrZZBvQ+aik132At/8+P?=
 =?iso-8859-1?Q?UNf0pvXEDP0TgvI6GDW105kXHRkFAGRZI/ckYQpGVUdSG4v+TsLOytGvvl?=
 =?iso-8859-1?Q?160nmzua8aCllI7SsMEOJ4T6Ut/0UvK5TEaEPWvUVDyO9ZywvctLsiMxXY?=
 =?iso-8859-1?Q?GTyiuWUV1aUNyzYedwb0HYN/wqLONCqKNSoDjPjmhJE+9Ll4Y6WP7BN6jU?=
 =?iso-8859-1?Q?+Odl2JeKnMZK/KimVfkOYtOZPbP6tgbhb8y8YGbATf+19V+cuKRegcCfao?=
 =?iso-8859-1?Q?33UUOMgITRrwr4E7gWfsrx1zJqjERT6G8padF3IAu2FFIf+XALTamRVsd7?=
 =?iso-8859-1?Q?7lB/e1U8NeaqruPYZdplho8PY/LKkGLt/MBE07yg2VFlwfiGJOZtK6VNbz?=
 =?iso-8859-1?Q?DUzi+9KkGk++t69hphIpu+X2x+4+C2UnLEaLI9Y5I973AUWorwxZ5owowd?=
 =?iso-8859-1?Q?blKkkrmbblLe6KUCK4V8YWc9Gmya/x0NEmeFe8J1Gpi0CRG2JDGVGDk5BJ?=
 =?iso-8859-1?Q?AMwKtjgQ9j4ZH9vI3f+gzUAPgy8syXY0iBo1VT3422bStOAgpgKSlo1Fhe?=
 =?iso-8859-1?Q?9YUTf7rvAFhWUJu6VyRCTX/2/DbRdHSng833zDk7xC5iUVrj+A9UNUAG13?=
 =?iso-8859-1?Q?uXAr1ZTFCiF/MLBeAx6i87VFPnbslRQ4Xw3tnolHOQfbe10Kftkr7S/5lR?=
 =?iso-8859-1?Q?yPJkfyBhx7tjBXE7yNAPROFRFGo5OSD9o7OKfiiKF3a+bsWrzIotdgdAsO?=
 =?iso-8859-1?Q?bHUvh9PppE+oXvNpyvT9us5+AEwXrTY5nq4bDpApy1gXqIyjY9m3MSUULi?=
 =?iso-8859-1?Q?uCqa9Li+96qJgXQNynr0bkkJOSspEowSiUQESoI0RsQwZvbYJQMbYUxToY?=
 =?iso-8859-1?Q?cS4t2s6J/hPGzkgHV3vSc1DdIc4mPA1aXpcqOzTnH+r3Mhd4m666kNyypS?=
 =?iso-8859-1?Q?EQNUokGa0l3BopITirFznwse63895ps2nc6EITRLtmq7L3dMjwHvWZh21d?=
 =?iso-8859-1?Q?yWkaFta6ifRTpaBsxBxfeMnDXN5eLULAtZYDMddoyLzj8sOXgoGHlPvXFF?=
 =?iso-8859-1?Q?ln5hC/HX77ywnJJFZNv3T3x7FvS7d5QldBfrd1tvFE754MDWi7C6J2l34g?=
 =?iso-8859-1?Q?OjZ7R/x5erUpVhqukoA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2c4d8e-cf70-4467-0cfa-08d9a9ec044f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 17:02:20.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZseFaSzbmM8gaUIFz0aLozyiGrVluIPWCxko7gwBG7dNYls6uaFFVOIu0NkMrywBLg9VO2rrQWYYD4U6PUB4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111170078
X-Proofpoint-GUID: zVYld7jJzNklWawAJofttbMa1vYSgYyc
X-Proofpoint-ORIG-GUID: zVYld7jJzNklWawAJofttbMa1vYSgYyc
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 17, 2021 at 09:51:25AM +0200, Jarkko Sakkinen wrote:
> On Wed, 2021-11-17 at 09:50 +0200, Jarkko Sakkinen wrote:
> > On Tue, 2021-11-16 at 11:39 -0500, Konrad Rzeszutek Wilk wrote:
> > > On Tue, Nov 16, 2021 at 06:24:52PM +0200, Jarkko Sakkinen wrote:
> > > > On Tue, 2021-11-16 at 11:18 -0500, Konrad Rzeszutek Wilk wrote:
> > > > > > > I have included  a link to the mokutil [5] changes I have made to support 
> > > > > > > this new functionality.  The shim changes have now been accepted
> > > > > > > upstream [6].
> > > > > 
> > > > > ..snip..
> > > > > > > [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19dcec130c5208f
> > > > > 
> > > > > ..snip..
> > > > > > 
> > > > > > Does shim have the necessary features in a release?
> > > > > 
> > > > > Hi!
> > > > > 
> > > > > It has been accepted in the upstream shim. If you are looking
> > > > > for a distribution having rolled out a shim with this feature (so signed
> > > > > by MSF) I fear that distributions are not that fast with shim releases.
> >          ~~~
> > 
> > Should that be MS, or what does MSF mean?

Microsoft :-)

> > 
> > > > > 
> > > > > Also these:
> > > > > https://github.com/rhboot/shim/pulls
> > > > > https://github.com/rhboot/shim/issues
> > > > > 
> > > > > do mean some extra work would need to go in before an official
> > > > > release is cut.
> > > > > 
> > > > > Hope this helps?
> > > > 
> > > > Yes. I'll hold with this up until there is an official release. Thank you.
> > > 
> > > Not sure I understand - but what are the concerns you have with shim
> > > code that has been accepted?
> > 
> > Maybe my concern is that none of the patches have a tested-by?
> > 
> > Probably would be easier to get a test coverage, e.g. for people like
> > me who do not even know how to self-compile Shim, how to setup user
> > space using the product and so forth.
>         ~~~~~~~~~~~~~~~~~
> 
> for the end product

<nods> That makes total sense. Thanks for the explanation, let me double
check whether

https://github.com/rhboot/shim/blob/main/BUILDING

is still correct.
> 
> /Jarkko
> 
> 
> 
