Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C96450A4D
	for <lists+linux-efi@lfdr.de>; Mon, 15 Nov 2021 17:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhKOQ7X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Nov 2021 11:59:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30278 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231463AbhKOQ7U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Nov 2021 11:59:20 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGDSYZ001106;
        Mon, 15 Nov 2021 16:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bGsvSB8tAKNPZ0SePzh+0cs3uJfSeqYRpjqp1bgSqoE=;
 b=t147peuvdN2pQCwekUqe3kqoE/bF1JzVi3FA+hdY2LXH/b/M3YAnukZSJqDUeGoB4daP
 DDklRaHT2NPNzURAvWntQl46bBcLFLVUIAKGmpixl505KBrg3uqlcFkXY6y2HVkpbb1d
 K9BmvFhYOHHD5HheuJQWD6/3mymZ+eo451oWyWaTWVI/PuyRKh1FLbr6u5+TE4715oEz
 wvvhof7LocEzdEh1WVKi60RBDsjgmSae+cfMtjqKhDa4NeLqMnwO4WPK99lRFUZcSin5
 G/q1w90syBLkUcO3BpqycAIRP12yjav9AlHlkchZJCytKJhO9nQWwKXWBZYI9tCqBsKU 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhtvkb6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 16:55:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFGp0wN159479;
        Mon, 15 Nov 2021 16:55:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3caq4raet9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 16:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikLjAx7YvDBL4NrDds0P5FisS6rD2LWdkjh/PRMtRWgdUUj1U/dnkwL+qMxWb37IkOKfsQm2KEJA7kl6jW4oOQqtKUXOSyNC1IR80ekP9Y7lNTbi8LpklyJbgwC9PTwNCFOhyYGhFHKPP5L2pAdSgG3js8+la/GG/j26FrbktkPUzqwndTVJBmlHQQNALvugcQCMErORJswNDBtY8hfB1JUNxKmSpY7F5s3Oe2qkhnIjwoJCOpbBjRR6oj31QU+FoekzB/fIURMqQZRm4FtO7DMyeWvN+XlODPSI+H6lYZwJ2CAKE6d8Z1XQAC65p5vo/UUjkLfNp1EiKX+Zbq5viQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGsvSB8tAKNPZ0SePzh+0cs3uJfSeqYRpjqp1bgSqoE=;
 b=XGRcfXjHTpFY7GhjScisWQanYTYkVML6prPWFUNBiC//b7WFrpkeMccExXhjchT6qxq3UL61E3cDh0JPcvOL1IouLJQasYqy4PIaa/TVDIf2oVt3DIAw7EtmREj/vAT5i3X0euUdUWa7Y0365Ta3UzgG/U08PrPXvxxLlY6IC/CF8fqhTOsshHzAKD7/gA35YpqxdvprOdnkdICpdIGxV9gwAPh8SUi4MWo+tq6JGe/BBQY2onNrPsBegaIYlH0XpUVOOSS4UNRLhU9b/NKxR8o3wyNSABnvXsfw5vo3IyaJ519Bzqw0cCSzn03+A/4Lr5RHsL+oekqM4WUJEvYhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGsvSB8tAKNPZ0SePzh+0cs3uJfSeqYRpjqp1bgSqoE=;
 b=Qkl0txW+nJrpH2WKpPSIP5Sp5YL9e6Hq39HoKvdWCWYAjjdIxHICrq7jGddzxZ6Bs0fRfaRnnClj0CWTsrYjJr6r8BgpKxLsHFf62eAtd/ZwF2jlJgeFswnzEaptCU9k2fSNvDoxUmUttAaYoYCyIq7OgKffRlI5rDYZdhOc0AY=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2719.namprd10.prod.outlook.com (2603:10b6:805:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 16:55:39 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::898:d80:7483:f023%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 16:55:39 +0000
Date:   Mon, 15 Nov 2021 10:55:32 -0600
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
Message-ID: <YZKRBOl9UkTJE4jx@dt>
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <YZKDGKOgHKNWq8s2@dt>
 <a631d02a-c99e-a0d6-444a-3574609c7a25@amd.com>
 <YZKMvjEIGarn8RrR@dt>
 <88aa149c-5fbe-b5c4-5979-6b01d4e79bee@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88aa149c-5fbe-b5c4-5979-6b01d4e79bee@amd.com>
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
Received: from dt (138.3.200.60) by SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Mon, 15 Nov 2021 16:55:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 296e688b-af39-4b73-8911-08d9a858c066
X-MS-TrafficTypeDiagnostic: SN6PR10MB2719:
X-Microsoft-Antispam-PRVS: <SN6PR10MB27194DACB6B9E0FA7F31520BE6989@SN6PR10MB2719.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIxGeLzBpwHk8xCFAgsRKmjiPHh5mHULm4RyWqepmr454e02xTN8Hv0TI5WvpZuZ6YWeK6AC/4LYm2+aZ9wZsDcLVabyrXT6uwQFqDrT6g3uHfr3+ppX0bNqlRgLQK1QKce8iS4prY5H1RfJeiqA4/Aqt32t5aprSCg7eGV+9YTLuvrnbmdj0hyL/UpNq1KplnIiQfBlbIwgh/AsAET4NzWsWcgZSkCAhK7bOl5U6x5M2WRixhdKas32cJGHxicjhEu4ySXCHh+hJ+UycIEuuoHyVXIqogi+YcM6nra6fEbGrzNZnlHFdOt38MuWdbBB4oDHIYN51sc7MHt4IBXHzxY6ReuIRNLKMGQReuNY74KKtrJaj6nh6rd8M7qLnIhPBLowmzoo1UZdBCdNYikUJyLfYHjeg0+wO/XFfuwQTQrub8fpUISbJndTVPWvOPNIJaiErue71uZpRABsl7zOAbf/KC5nArOHljb1FZwDVgkFy+BXNRA7xGu/NLzHFP4h3CsVHWUZWRyiOY0Q3tz0sKp8AFCu20rmZtcMNqxHOiW5ZFSuuX9KlxcaO1HSRD+YwI8nCa6RkYVMRwIWeIMpvKt2kPGj1xf5Hs3jd71HtZYIoYBemxsaZPJRYobtOBtREBHsg6LmTyvtw4AfFMKh0LOU4dcZtGehmOgIYCwevousiB5hPOiEy9p2q6OLlvyBBf1EJhkGvr8BwHjhz2KxLr/jFjpHBlVTWpGQzNylDia0nuw7MO4F1bg/dGdmI1FypPcn0RF5HxeNYJmdcnMFag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(316002)(53546011)(86362001)(956004)(44832011)(45080400002)(83380400001)(2906002)(38100700002)(4326008)(66476007)(66946007)(66556008)(8676002)(54906003)(6916009)(55016002)(26005)(9576002)(508600001)(8936002)(33716001)(6496006)(4001150100001)(7416002)(966005)(186003)(5660300002)(7406005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0onytMseYy941WB0TSy1W4ZxBNWw1J25AYBfGT61/APOiy7jzOkAnXrrDcP?=
 =?us-ascii?Q?ze2r2X4sXopaPBKv8HZ+m7ajNeO5Nh8ET8bVe1gEiLTvRUKOwpsNckowo6Ja?=
 =?us-ascii?Q?X6kWgcso/Je4tBcVfBqkIGmCbQQYouWCDCghEgolItL7LjV7BxsI1evg9FEn?=
 =?us-ascii?Q?/JtMib4VF+UbVd+dTmOuJMFr1VdRyNjkDghMcqeSZYThWvnuLydZHIRPY3z5?=
 =?us-ascii?Q?CUhIbAtrg2XJhy+dhg2J3v7OoU8WYl97EM22rrzyUTK+Yi23TzSV0DkoCS7n?=
 =?us-ascii?Q?lT/gGj7vJRWsvNQRxKDGS95yzLbH+6048V4O/JiiKMZ5Z7hYkEwowygyYBCv?=
 =?us-ascii?Q?V70lAEytFNRmCShb7wy8UhJc+fKb+dIE840nJnGzqbQiEJn+8AshNypZoKuK?=
 =?us-ascii?Q?b9gIgkQQj4Fg2xWIQ4OemSlvLuqdvqO7sijcME2YSBKw/I5IvsAxj2xm4Us/?=
 =?us-ascii?Q?oqm5kqCchofjEEeZHdniWsxgVxl2zPhFYEmuOPm4HnlC6L561/U0GqOO9ExH?=
 =?us-ascii?Q?SAL1Ym8cHwaGLHN3sTav1MZ1NqUlCN8nbDhEKn0jLfFx5E1B+2fEFWS9Cjrd?=
 =?us-ascii?Q?J1LyhxkJFGQiWNIuAWpbytW1Tt7/vXq1JO2qjcCn5AnPQ+nG5QHiG8xsZE0D?=
 =?us-ascii?Q?hYypqaUJRsBBkNQioMjcyBZwjYbzhzCgYOoiNKiM8zuuL5FHSqOWLki/Gz4a?=
 =?us-ascii?Q?rglBakWu66AO0zbSbqRgZhY2Da/so4/qWNsc+WHOhldU4qhkfcugg/1vb6z2?=
 =?us-ascii?Q?xhqPAiePquvU5bSf4SG1IXbSV5RvttuRGGmwvYwE/wV4eutBTIpdMHpPuORN?=
 =?us-ascii?Q?D6vFZVsi1O+24pIhBgcBUO+FE+K+YGdZfFlvNNwT9OmcicxOIs2r5h9xycOT?=
 =?us-ascii?Q?7gkXUG7cstLqfwama6Ps4Kn1pvcV0+jin5MyqAVEx/rLdGUNWM4XNrdsEwLA?=
 =?us-ascii?Q?wz/1BmMbjGJvOh4nIpJhk2drWCXzqbX+Cpw7OKTAhm8ifd9orbPReUTL5l2p?=
 =?us-ascii?Q?tlcFiqRzgJ6t6f6RTBKVj1A6SZfLKoi7ZZw5tqmASKMPXDzxCmAYN6rS+XWh?=
 =?us-ascii?Q?d/YdTXA+BE0MJU4J9ii2xJyZgX2nHmsHaLO7LdTcIV9HktdVMTgReUq2fFTy?=
 =?us-ascii?Q?PWKKPkWC/QphHr59XJdgSIv8CTaDFDAF90dZQk8wFaUPJo4HIAvRXRlkdwF2?=
 =?us-ascii?Q?NrnK4Za8qqhW2IVShuJ/TvBPB0BPmuClDLwnKhmtlJC89ejsPJGQGpwSvNjk?=
 =?us-ascii?Q?8sTa//w44ufoyrQFJnKLMg6VJydddBLp0yx5LGCY/EXlIJxKwvlWnQvAr222?=
 =?us-ascii?Q?CKPrEST0Op+p7jwlmdUzxrGMG39YFKI7FksVtfv3f8XscsqaMTztCuBnFxuG?=
 =?us-ascii?Q?wzl/tPUo2eeIl3XVbEBWaxOXeeNbw5ViXlUjuurEel8BLQfAS+16HA5sxVkz?=
 =?us-ascii?Q?vVd0V0+1aWeH4JBBCzLFsZ0jHYjlidFXUOHrd8NIBP/+kwwGGkUYNjejAFAv?=
 =?us-ascii?Q?d0R7vCjSr4DKlvyKWC5J/0FSfZu0MPkNmAcUH5BDEgKwZjozgInB0JfZv3MP?=
 =?us-ascii?Q?TbOCzdx08Cs+36zi99EBUf2DBM/8Dw1rej/Y9BKFW68UZBv3gzB22FA1coeA?=
 =?us-ascii?Q?OqCQVv0LyRwndBbSJSpvQQYVar4gRau3+1FFNs8YbdIMkq1+SmwH4q5tKt1/?=
 =?us-ascii?Q?XxT2Iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296e688b-af39-4b73-8911-08d9a858c066
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:55:38.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CbsyfYM1TpqM975NMvuVPs9kynn52GgiXbrKnT8OU2SFsSUYNCE/HNYyRdzhTZHCGTdt+smdv6WxZSJ4HJ2nU4wjmRH2RQ40s5D3e6PXHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2719
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150087
X-Proofpoint-GUID: _BCuLooOt8FIRR3hWi5ZAbiUxJVc4EF3
X-Proofpoint-ORIG-GUID: _BCuLooOt8FIRR3hWi5ZAbiUxJVc4EF3
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-11-15 10:45:48 -0600, Brijesh Singh wrote:
> 
> 
> On 11/15/21 10:37 AM, Venu Busireddy wrote:
> > On 2021-11-15 10:02:24 -0600, Brijesh Singh wrote:
> > > 
> > > 
> > > On 11/15/21 9:56 AM, Venu Busireddy wrote:
> > > ...
> > > 
> > > > > The series is based on tip/master
> > > > >     ea79c24a30aa (origin/master, origin/HEAD, master) Merge branch 'timers/urgent'
> > > > 
> > > > I am looking at
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063489322%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=CT%2BZ6Nm6pnvVGY%2B%2FmzK4gG1zxlMNQ1fn7ie6K%2FYueTQ%3D&amp;reserved=0,
> > > > and I cannot find the commit ea79c24a30aa there. Am I looking at the
> > > > wrong tree?
> > > > 
> > > 
> > > Yes.
> > > 
> > > You should use the tip [1] tree .
> > > 
> > > [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git%2F&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=XnWIcW62nTrAcDLCkHFpOPv5%2BClg11wfyh0pJ9Dug2c%3D&amp;reserved=0
> > 
> > Same problem with tip.git too.
> > 
> > bash-4.2$ git remote -v
> > origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=W%2BA8qZwPicXo7OSslFPqL8s8QRxzW9n68TX1B7MXFYQ%3D&amp;reserved=0 (fetch)
> > origin  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7C566cca1a4ceb44dac52f08d9a85639fd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637725911063499319%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=W%2BA8qZwPicXo7OSslFPqL8s8QRxzW9n68TX1B7MXFYQ%3D&amp;reserved=0 (push)
> > bash-4.2$ git branch
> > * master
> > bash-4.2$ git log --oneline | grep ea79c24a30aa
> > bash-4.2$
> > 
> > Still missing something?
> > 
> 
> I can see the base commit on my local clone and also on web interface

But can you see the commit ea79c24a30aa if you clone
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git?

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ea79c24a30aa27ccc4aac26be33f8b73f3f1f59c

The web interface has the weird warning "Notice: this object is not
reachable from any branch." Don't know what to make of that.

Venu

> 
> thanks
