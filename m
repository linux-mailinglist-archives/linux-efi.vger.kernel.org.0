Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A4245364B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhKPPt4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 10:49:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6042 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238550AbhKPPtz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Nov 2021 10:49:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFNkZJ013942;
        Tue, 16 Nov 2021 15:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=VVAVvxd/BTRyDrlSsGL6XuEi4oQJmnb5IoVOf2QeoYk=;
 b=Jmca4oHkPlg/OfDlQQK0EClvwRXGQLFC+F+1lmFm+rkNfnErCjAdM+1XST//ALNKSiQJ
 Znb6Dj4MB4wOMdcV4ezz322QHkUnj/v00Qv7oqVZNBN/RqWAAC4LuYhPngQeR3MtzWoK
 O2R+9FowPtaAiEguBK1EPYj1YXHSvMTVeAFQBq7baCitnByJtD8Gzz50jg+gCngWcyDv
 shPS8IRKQxqYmpjasDSPYHTUCarowNIOm7XmAlRU8go2cIGUZFVkfNmhuIhr2tMJYcc9
 V+0fydpSkkWEJvLalHKE5OgkqCN+eDPAe+QrEssGHOmk5zsXx1aYZ88AJzSgOQczeguy xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv5abds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 15:46:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGFatSo098330;
        Tue, 16 Nov 2021 15:46:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3ca565mbcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 15:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ8qjvFzpHvy4UtKSaYuAxbeYTzFsoVeFtXrXRKbe0WqtWjPOdM6MkEmJkPh7eKu0DRLNwjuctZTtw+gsE2+OKaeHw+CfPf3Vx9aepjLZazLtNPdcYge1gii/jCf+Ip2+QqUZRyD8j7OpBfHrb3u6SXHhSCz9SoQTwAZ9VvdcVB+4T1dxR1srdE3yt3FIaggAtdu4SyUbuu0KbS/MZgWeVD0aFN+7oLoNt9SZGVWhh4hb+gyT1cviCn9YG+zb3G9jVk6d6qvWVoKSZ2mpnfA1O/st5M+f+BX1F1GP8a18zftJYA2q63W8rGv1koeLaherPSh58lK9CewCu5pzoT69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVAVvxd/BTRyDrlSsGL6XuEi4oQJmnb5IoVOf2QeoYk=;
 b=fiy0uC6/WJ4qcLnJn0LCcoSWbzE+Ahiuj330Xtwh2kT1BuWgWKAkSCEa7YE/Vun0vozLKRvKfouV0Z3zgpeqTYQvXEb+RvDs2sGx2rRjzJFQ2DdiK/ThtNUEswR+HRG+uk7eANLvlTRA0fOEhwxmJai3YWBxvQsD6JK5OMOK78zmz0OFZ2JPvULC5+UjkMLlqAAjr6OV+HaUMg252JdSoGNFbIYBgat05TJk0y9mT+gNgfV9iqD/bGUQ12wNPxgX+Imj8/1/YaC0dWjdZBMNbShLp5AEhpE6cql6VON/8btIVXkIpq9GlMA68jZwq4W7PWEamv3Iryg0QhlAj94tUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVAVvxd/BTRyDrlSsGL6XuEi4oQJmnb5IoVOf2QeoYk=;
 b=auIwnHHWp2FbtAMLI+dwr1dxkOcPe7ub+u3cuf60BKehFuTAZcBUaWVebgaljOuk2MD0b/k8aMdwZJzzmoJ53EQ2QLm9H74o4L9i5dpxqzHDCwxJyRXerbIQjp9gNwpOKWR4nY88+PHJ83jDUxbK3tEAdjjeq/WUqfjNXfVwm3M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 16 Nov
 2021 15:46:06 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023%5]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 15:46:06 +0000
Date:   Tue, 16 Nov 2021 09:45:59 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 00/45] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
Message-ID: <YZPSN1Ctl6H8lxsR@dt>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <YZKDGKOgHKNWq8s2@dt>
 <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
 <YZKMvjEIGarn8RrR@dt>
 <88aa149c-5fbe-b5c4-5979-6b01d4e79bee@amd.com>
 <YZKRBOl9UkTJE4jx@dt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKRBOl9UkTJE4jx@dt>
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
Received: from dt (138.3.200.8) by BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 15:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd9cad87-2e6e-4348-c29e-08d9a91833d7
X-MS-TrafficTypeDiagnostic: SN4PR10MB5623:
X-Microsoft-Antispam-PRVS: <SN4PR10MB56237918ECFED3DCD729C1EEE6999@SN4PR10MB5623.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s0ZaVZvPy0cIDncameaKLEJi1Hb4qkAa/JCWdu/hhGJ3hDhzSTA5oIm8B1HuXVzd6s0C0j/z9UHizjqKDbxuZwL/EHkz3DMEq+rmlV1dDd6csbP2IemMLBnS4N3sank1GShfm2glaaEhIKaPzxVo4BZbwhQBjlT1ZBgQVljCCcRnWqiSCkDHGO1A5WAvZ28NeDqqDfrmDWdjBVyPLKiSkgrTSgrdqJRONYN1ooQ1dz1UiUzJBR1kjaYya9kS+VI7CI5sfUrnduizGcntX6KNMts5MLytjEUD+wKgJS2BdSQUOtSOM/lpPjg9Uo03qBpJgAl5tL30Vysrzvfs3Q5t3UfJPvU9gJ41CceZTQEH9DaROruZQw7chpsJ7scvh0FO3oyTuHyT7xAVMdZyhkwk68KQY4Gt+wJWCtcFvHnr6zaohik++Xx20Ej8xOMN9oTOqEQ8LChZFsuQIv5L/MLO6l6QZHjMJcNZIjLftpNd5fnFjN7eLa4omJBdRZiEmRDVo01Ly1cZLVwkpXolK27RT+LTmq3zMcVNCG51LzM5TdIDTWtXD/mmWdjtj/0hOWvj5hhwtGexh4bCnyAoorzybUkrxdP0g1U0Jxt/w/JwVEfq/Edp/33D/GvKLr/0Y8M9sB79ALAdYDy+o9XN4059i9OaGtauh20BEpG0t4GthSG+TYwikXKlxgt4FoWZEGFmBU6K9V1v5qm2FPle0SpwR8hidSYb9NNuC+QPOmE91nCZmg+YgwREQsCQAMgpEcIcTskCdIS5PdIXWkdNOD48A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(54906003)(66476007)(26005)(4001150100001)(66556008)(4326008)(6916009)(9686003)(508600001)(956004)(33716001)(45080400002)(2906002)(38100700002)(66946007)(83380400001)(7416002)(44832011)(53546011)(186003)(55016002)(7406005)(6666004)(9576002)(86362001)(5660300002)(316002)(6496006)(966005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLb+xfYOpy9BKGWzbfvno9cYxEZkunsW0C1A1ysC8PMSe3cJprPRk+Tjh36P?=
 =?us-ascii?Q?8aMZwaBrPd5TbkNgpZ2Y7kZPNSEHWwpNwME9x9Q7pqw7cbNYxaS62hpnI33n?=
 =?us-ascii?Q?17fXKPhcfma+rB0nib92CuxdTL7mwnWG/03u5SFyYHAp9eaI1T4wsbNYfDtL?=
 =?us-ascii?Q?/1DI6CXp0odiQnx1ylRRtIHTAWaUSCXeWFGzj5bMnAZ5ZwzsKHVNegmqjwfO?=
 =?us-ascii?Q?mxWmTEg1j/BvdD8yDhb82WMsIegeTon1DfGuK3llcD5v08cu8VvMNXPySwmc?=
 =?us-ascii?Q?PYMOWOoUGx00CqObAaeUsPBFWEHybalgwMtI1yZ8SmLOeNqMzisgKk7azL+Q?=
 =?us-ascii?Q?mrJpzNVbXSJhRJHm4Mf3zepHGj9DaJ5gfC8t8aify4f20btMQIU5JqNdQvc3?=
 =?us-ascii?Q?Unq1OMXUeyC05ElQDt8j8sKLOj6O8SzEfvg7WnrfjIvkn2kkjImF22sbZk61?=
 =?us-ascii?Q?NE0PlJa4h++k0toi+InRqWu7VQZJQacJ33wBonRR1/CmeYWfthV9nEf0SD5l?=
 =?us-ascii?Q?OjMU4LWw1k+yhurB7BQDFKeF0oiGnKPNJdKsSJWOYspPRx4eLVdm6909naCs?=
 =?us-ascii?Q?NvLoy2XofL/dRki3IWLklFOumWtkK9O5LhOHPx0mAqOcyJ/ygafKq2plJHv7?=
 =?us-ascii?Q?f+ymXL5Df9pjpzmLhGITokPbi05WGQRITJp4EfNYh46QvrBDAbgdhvhncbU/?=
 =?us-ascii?Q?84SCc+NDGQtr+5p+hkd22xbsrt9XkbZbmu8sHzik21rVD2vntXmlhVQNSWce?=
 =?us-ascii?Q?s4ULj6XEKIqtbrG/YGq9YXDUXlx6k2mTA3Xy/VSkALgSb2AiVyfMyLlTUjAW?=
 =?us-ascii?Q?velsuqhbub9D5pY5vdd7gglCG5idAQNePXdr/HnYK6R2IhEms+pB1JBQW96s?=
 =?us-ascii?Q?aUlQqw1MgL9u5gseqBgmeP5uYZ+EiKvZX3mRtpCNlGQnuk9/TeXngEWenaPJ?=
 =?us-ascii?Q?NTClREBY+xFo4loffn0qjxGhnyBVQEzKw2suYS23NvJuApU8qq72AQxdhy0J?=
 =?us-ascii?Q?D/ZbKxMi45BWKZ4HsZl6FsAOTtWT6M5AlM/OuYeD7PvTwdhegUIgr0nF9W8V?=
 =?us-ascii?Q?VRECPrViy4TSDAUg9ihz7ArKP72mc7AHcj7RzDDnuUUOf9k9A5yCZCJ9/HGA?=
 =?us-ascii?Q?0HLADDvIYkuCh+DrLZ97JRewK9RnfwIGPX+hL9r+KXGzywJZ8vOE4MVqaeVT?=
 =?us-ascii?Q?HTCM+o5mx760AzleTAVoTuPe5xFg+EPS4aMZXbrCueiU40tt2j1FKiKOv9N3?=
 =?us-ascii?Q?T4OTr+Uac/KWpgEBGr4g43yCjCzMi51C2BsZI5RdobKlv+aF7nwyTe+dmv5e?=
 =?us-ascii?Q?qz8+PHAE2qc4EJKnKMfhVn52CvQe2pEDaZhvyDdTIjnGOyiIPBPR34JNhzSh?=
 =?us-ascii?Q?zqpl0Hu/dUQPe2fMkKOoB2T5FgjU73nptzCQVzBVZG5Q8Y9Sv39GBLhgOHdX?=
 =?us-ascii?Q?NCS4B8ZcX4MlYzoCPJYA9ClW+JEnx6rtc8ce576p/71o5MGrau4AVRXKdt99?=
 =?us-ascii?Q?Y7IR09yMWoQ2HEv2jCt9IOTENxUYOm2udlXh4QXZIXT6f00hYV1Sk1LbPrdu?=
 =?us-ascii?Q?FvBWjckCzBEp6N8MvkFQ/v1rdydiEQZyrbyRUeNH03ODEDC/tKODXfTMMTlN?=
 =?us-ascii?Q?SqSOdkk0ZEHspE/cGM9W4htFZeiKMiiJ7MnIuQMoA4JNYKX20UPkBpDTVBbm?=
 =?us-ascii?Q?AuZ+Cg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9cad87-2e6e-4348-c29e-08d9a91833d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 15:46:06.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1kRNlQjXo9396Et0Ow0f5hKIRazpW+n0UWhFeA4noSpmfLThL4SS0xFJKYnglIsFmtNLqCRF0u1c8jF0Y/BsDybcksCh7SHqRcqFmhOg04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160076
X-Proofpoint-ORIG-GUID: Lgcw3WZJy5ytHBJLAdRbviMfIobHjkoK
X-Proofpoint-GUID: Lgcw3WZJy5ytHBJLAdRbviMfIobHjkoK
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-11-15 10:55:32 -0600, Venu Busireddy wrote:
> On 2021-11-15 10:45:48 -0600, Brijesh Singh wrote:
> > 
> > 
> > On 11/15/21 10:37 AM, Venu Busireddy wrote:
> > > On 2021-11-15 10:02:24 -0600, Brijesh Singh wrote:
> > > > 
> > > > 
> > > > On 11/15/21 9:56 AM, Venu Busireddy wrote:
> > > > ...
> > > > 
> > > > > > The series is based on tip/master
> > > > > >     ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'
> > > > > 
> > > > > I am looking at
> > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063489322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CT%2BZ6Nm6pnvVGY%2B%2FmzK4gG1zxlMNQ1fn7ie6K%2FYueTQ%3D&amp;reserved=0,
> > > > > and I cannot find the commit ea79c24a30aa there. Am I looking at the
> > > > > wrong tree?
> > > > > 
> > > > 
> > > > Yes.
> > > > 
> > > > You should use the tip [1] tree .
> > > > 
> > > > [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git%2F&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=XnWIcW62nTrAcDLCkHFpOPv5%2BClg11wfyh0pJ9Dug2c%3D&amp;reserved=0
> > > 
> > > Same problem with tip.git too.
> > > 
> > > bash-4.2$ git remote -v
> > > origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=W%2BA8qZwPicXo7OSslFPqL8s8QRxzW9n68TX1B7MXFYQ%3D&amp;reserved=0 (fetch)
> > > origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=W%2BA8qZwPicXo7OSslFPqL8s8QRxzW9n68TX1B7MXFYQ%3D&amp;reserved=0 (push)
> > > bash-4.2$ git branch
> > > * master
> > > bash-4.2$ git log --oneline | grep ea79c24a30aa
> > > bash-4.2$
> > > 
> > > Still missing something?
> > > 
> > 
> > I can see the base commit on my local clone and also on web interface
> 
> But can you see the commit ea79c24a30aa if you clone
> git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git?
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ea79c24a30aa27ccc4aac26be33f8b73f3f1f59c
> 
> The web interface has the weird warning "Notice: this object is not
> reachable from any branch." Don't know what to make of that.

Just wanted to clarify. I am not interested in the commit ea79c24a30aa
per se. I am trying to apply this patch series to a local copy of the
tip. I tried applying to the top of the tree, and that failed. I tried
to apply on top of commit ca7752caeaa7 (which appeared to be the closest
commit to your description), and that also failed. I just need a commit
on which I can successfully apply this series.

Thanks,

Venu

> 
> Venu
> 
> > 
> > thanks
