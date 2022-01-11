Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775A48BAE6
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jan 2022 23:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346604AbiAKWnm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jan 2022 17:43:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16366 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245679AbiAKWnl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jan 2022 17:43:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BMeeaH019911;
        Tue, 11 Jan 2022 22:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Tq4irZR979XssG+MXJh53TDtP3QW5P5ytTgQ6H7iqns=;
 b=EkSxla/romEWky02AKB9PH5/iaz59L0gTZwNEHymgAkW8tGj4sX67I/4SjCvBcGnhBVg
 t+U0gnxU1hDXUNPDo1Ro4WwsLQfHBVBeSnmcIgqdDauuUNaq8ll+wuwkLyLOLRwtlGzc
 9XM6Wn3lTwaSzTYC9F0xmWxmyzP9InN/lGMZnquiKmR/IPWJbxykRFI6JrD56P6Gq5Fw
 Eo9mT4qJ6VNFyuDgpKFtz9d+X5H/Xv3erXyZdyupWFCBQcA4HEwpRuiOxgkYs0UojA2b
 jfwsSQZbOmf149ypMT7SWYi54RCOhUVcxIXd3E9LetUHarHeYpauCiDsUvwWSCQCQr/t lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx4kr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 22:43:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BMfeIG071951;
        Tue, 11 Jan 2022 22:43:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 3df42nh6xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 22:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjvEgHBjd+iZuJx6Go9Hd2N0v2W0R9I++sVUSARedSUDC4dwwa9XzbPqJQ89zao/tDuIygHVaLAttWYfNEN4czB+aUrK8jR4goKaug7NNN4g1Od/dV87blL3b4LDwEIDMXiTxH1KqiW5I6VxYzq2Npn8FA/C/r56lkdsBVwrE8Vv2RDHUY8drYtqODI3eFmobFwxT7hlWQXgzld0l0DTvWDzQZA9UdQxi6KrDEjrCV2ZKWgSOK4EXoRfqc2ASREbLkVtmEB4HyTnWXhYMKLg50Je/JA+J/pV7KUVM2Zb5MPLbFKL3BKT/IxFcEHrbOKYkJxjX6gY9fNV+rsUt2ILpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq4irZR979XssG+MXJh53TDtP3QW5P5ytTgQ6H7iqns=;
 b=IsUfBaEBJWUmALok1idhdaBLxDDbRYNk7JP02Z2ExzF6iYj/RpmZ9urI/E4ZxggbEMW9k8Ic2eNtWUK2PsRDYR4MoPCJA6Oz7q7KJGv8FKSqTA8sZpwMRFs6OsrAD6r3TMhlQBFyQJ4sIaC4TrrD0/ZHClyy6r2whJO8fsiQ9aYImD60q3gfqaW6+0zsn5BR6PQlMhZ1v+MJRYKrqqkxn1s3pa2tLiCzWDKZE/Ukoja0PDwt47yZE9mbDGkqMn7ZA7rT41FHXtI3nIrInr8+P9Wq7Gx9SRe+GsUGf+blT4NOD7LENe6zaC1G4VOI3+Lxw/DaobviXN/32Jxc3GD/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq4irZR979XssG+MXJh53TDtP3QW5P5ytTgQ6H7iqns=;
 b=mwdu8xrNeYr0qp3zeq/zFf/Zsfgc9h8y8uQUJnVLvqMmjO3Uz+byagWeqW+8b3DA8Zyn085VXdLF5GbWIMDw/UAiPlGiQM1to8D+bCGblzxF/BSJbGDZJsmdTE2pNO9aaorb5OhoS1jB2JROgEuwu7Bdc6HrPWE1tpKUZajc7Rc=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4796.namprd10.prod.outlook.com (2603:10b6:806:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 22:42:57 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 22:42:57 +0000
Date:   Tue, 11 Jan 2022 16:42:51 -0600
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
Subject: Re: [PATCH v8 12/40] x86/sev: Add helper for validating pages in
 early enc attribute changes
Message-ID: <Yd4H6/inP576Kppv@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com>
 <YdOGk5b0vYSpP1Ws@dt>
 <7934f88f-8e2b-ea45-6110-202ea8c2ad64@amd.com>
 <Yd374d2+XdBD+vTM@dt>
 <91194a7c-b363-6356-4148-5a5222b86a59@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91194a7c-b363-6356-4148-5a5222b86a59@amd.com>
X-ClientProxiedBy: SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c8d086-44eb-448c-dd56-08d9d553b6a3
X-MS-TrafficTypeDiagnostic: SA2PR10MB4796:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4796B76ACC1921E496EC6E7DE6519@SA2PR10MB4796.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XqUEZ87NOE/wKQqQOX/vXAm9/lphOM57e06+fdsqs9GhLvjTJprVFNbwL3/FOGC+br7rliZTMC2fUF4It+8PMZEQCidW+6K12l8fG3jNwt++7iDXdvZV2DVfCUSwbvkBXZjBMB0d5Oqy7ahdefRGg7WpRPZUvg435nL3GG/DXBjIHGarYewLZbE3VqVetnzoOn9IsKOCh9VZJR9r9tYVeOeo5OttGp4b7rjoLAx1Ut801ciuOfaFjXADmj59Xf3IHvAcQBR1Y8qZtGDUhMaOBEOSj714JPyCvzheaF4ubBI3UqqKXY9ajoinTaUZ1CsXs3PB3Pfg6EnRvzL5uTCXsuWuMG6eJhiqbU/2IX/m0sy6b44CxvMlipgXKrqufA4wE1B/dlwAiTWqSug/POSakcUA0jRmEgYRYp0ACI3q6pRoFHVi8nLbxJtE9cmwPDIPSSqCgJePWGkMUSG1I6xi0COXHUjp6yfZ4JgW2yC6NcJ2veRf9Ir2PkrIxuPU+LuTCPPjmMy5gyf+3htJt5C4OUZl+3n1z3mvjdFM/QuqH5uaT5gzhMsLjSBWj+KqaztuffQcAZytJQsOxrekyAEUfSMkIbxzwvpdQvkgxURXF7vcZKbiu8xXiD7w91/1degYrQv5vv9InV2f01EtQ1jc5BlA408sHUdPgfMr7uaStevDqDbwxVT75OppbQbNaI3lD78YWmb+tz1Gn6IinorgboFClBpC1RWrAQMxOBnK3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8676002)(4326008)(38100700002)(6916009)(2906002)(316002)(966005)(33716001)(8936002)(5660300002)(83380400001)(54906003)(26005)(44832011)(53546011)(508600001)(6512007)(6666004)(186003)(66556008)(66476007)(66946007)(6486002)(7406005)(9686003)(6506007)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iwjITBpOOsN4Hv0rpg+RFkB7g2wA5A80+GQxK6x9RgkrRYzo/VxCEZkSkvM?=
 =?us-ascii?Q?E5Z2SVAkOTup3MQVdnn+q0ysBuM7I92SCNOtF/M14YsUpi6laNK+DyReSTKu?=
 =?us-ascii?Q?Z77fyCXzHz7u7hxL0Tb0MLABUi0GDJQzzKylKXG7I530iO5Gxi+Z9mQsO9Fj?=
 =?us-ascii?Q?jpcogYyn6W1dJUQqGE7YyoNNRWju3Hyogwl35XR5zy9EjKdVH/VzJQjY8Img?=
 =?us-ascii?Q?PilKPw0663TuObuUhTtMMfNKWQ8tZKf6oHkdnb/XUWkIkgd5KxuWWBWivdwV?=
 =?us-ascii?Q?lwO8FkXmu0sogLjsG3FZOL1RxwXUx/cD/qPVxrGRVnaBa0JeqNVG/RyJL/b8?=
 =?us-ascii?Q?QEj4MoDbBzQK0/qdSJ4eunb7mVg9vRPk0jM9TYIqab01d9EZL+WUImC0JNjA?=
 =?us-ascii?Q?QQjHbL46a7QuLku8E8BYtN3SzQWLrcMOHP75gB1qyKqjq2LdEEbOCzcFADx1?=
 =?us-ascii?Q?hzrjVCkGrXZ5HYLcdiYxw0pGEP+GMWod+zTn8Pa8x4c2zcA2jKxtk8/1BjNS?=
 =?us-ascii?Q?pCLYUbPkaWdcmtFI8J/UCoaKgrpd6J2JAY3w7sNiyJp9/rgWpXHv2ipGVqig?=
 =?us-ascii?Q?JkGdgpycBCGfco0BmHHn0HKji2bX6JUIjKILb6YLurLM/rTjoQw1tdAe74dM?=
 =?us-ascii?Q?XQ9a9nAIbu/Q3yc2PiXbgb958tSghsEIcZxkluvczWMjIpXzKK2/U38E7O3V?=
 =?us-ascii?Q?4KwGlENk4qDkhIFkAovN+1QZAbwlS+Vhl3QwgZ+YPnzcBwIZSxCtIbm3bsxP?=
 =?us-ascii?Q?05B16Ka9NktmWtbuQ5OyxtkPTs9k6x8GJZb+y5AcsjOTR2IjNnFAunqK2T+7?=
 =?us-ascii?Q?L69erj7dodQBAX9BEGqRi8bArcWswx2h24VtjzulV+E6o+zBmbKw7ACUnJ7e?=
 =?us-ascii?Q?7OgDnjI16RxgdgBsLTyNhsBt6CG5fndHMR4ik/paW5iIkbcVnAk5FQLdmnJh?=
 =?us-ascii?Q?1CAvLBPjdC4FooMKlGPKyuFQE9bK6+33TwuMm/KASdRNh8c1uwd1KApZcxjD?=
 =?us-ascii?Q?Q69BXXopK+dae1GZIM20FOC/v82UxlhIK366YpKhcnPXswvfrsuY0CcbYC3c?=
 =?us-ascii?Q?PVM5QVctQpv1Rj/9ZQCR6PkyBmzuL9ObnGorX6nifKnSM1SBe7usVvlH4pzN?=
 =?us-ascii?Q?QBJNN/L/IWNy1nJ92SFGcw0DO7cb2zpYGhnkLeArDuE8Jie1vJL/UtX9eb7v?=
 =?us-ascii?Q?oEfNQGQ+F60kSdm+kK/0PofqKlbRqT+kMquCORydDZ1cD4q/T7uTsTAFYKDJ?=
 =?us-ascii?Q?zVexMYx9nK3uXxY/FRd4GyE4Uwu18XyWr85vjSu5N0higSIhTPzIOy8WjOcU?=
 =?us-ascii?Q?FBKlf88csBjLCyXK2n7Xpr/jhJZ0JIOGwoeJq6aUOWNn6btcKVmp8zI0BUZK?=
 =?us-ascii?Q?RmsY2KSBYP3uEVHWGDGAaYFmlqXVcrmtZYkQtFgXdHrDPZEqwRFyptZEUwMk?=
 =?us-ascii?Q?jsi5npoVgjNwqtmcbW4EWETdi10qk2u4iEA+/7DBYFUe7tu8NH9XQVYUay9x?=
 =?us-ascii?Q?F3QvZfhr/5nWkv3O1h1NXsmBTqkzMFVqyTGYnuf9QrJxMPDlUTZ/FmBnhEib?=
 =?us-ascii?Q?fzj46n/0WFisAc7NgItys/Rdnzv8L6KcTNzEWYyxbje36VnSLbsaqnKRQ0Kw?=
 =?us-ascii?Q?xaniFCmXkHV3gzeQqOA2Ekwd9qz/5uLEsE/NagR0wO59yKsb0Y+Eku6tnpCk?=
 =?us-ascii?Q?UeFF+w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c8d086-44eb-448c-dd56-08d9d553b6a3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 22:42:57.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTvSVwpkCjhFj1I9HXSwJLkKu3X1OixtbRxwWyeBtEbSxeuKGj4aR+QiQJ6Mo4cR+SMbDS3R7OnGZS4pQYMA5IVG/J0qrS18eNeAczm85d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4796
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110119
X-Proofpoint-GUID: gNmq-IqfPnsmlcjVVCw5G1pmL4eFVy_R
X-Proofpoint-ORIG-GUID: gNmq-IqfPnsmlcjVVCw5G1pmL4eFVy_R
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-01-11 15:57:13 -0600, Brijesh Singh wrote:
> 
> 
> On 1/11/22 3:51 PM, Venu Busireddy wrote:
> > On 2022-01-11 15:22:01 -0600, Brijesh Singh wrote:
> > > Hi Venu,
> > > 
> > > 
> > > On 1/3/22 5:28 PM, Venu Busireddy wrote:
> > > ...
> > > 
> > > > > +
> > > > > +	 /*
> > > > > +	  * Ask the hypervisor to mark the memory pages as private in the RMP
> > > > > +	  * table.
> > > > > +	  */
> > > > 
> > > > Indentation is off. While at it, you may want to collapse it into a one
> > > > line comment.
> > > > 
> > > 
> > > Based on previous review feedback I tried to keep the comment to 80
> > > character limit.
> > 
> > Isn't the line length limit 100 now? Also, there are quite a few lines
> > that are longer than 80 characters in this file, and elsewhere.
> > 
> > But you can ignore my comment.
> > 
> 
> Yes, the actual line limit is 100, but I was asked to keep the comments to
> 80 cols [1] to keep it consistent with other comments in this file.

Well, now that you mention it, the comment that immediately precedes this
one in the file is 91 characters long, and the comment that immediately
follows this one is 82 characters long! And both those lines are also
added as part of this patch.

Venu

> 
> https://lore.kernel.org/lkml/f9a69ad8-54bb-70f1-d606-6497e5753bb0@amd.com/
> 
> thanks
