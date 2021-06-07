Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1C39E753
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jun 2021 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFGTSv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Jun 2021 15:18:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41206 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhFGTSv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Jun 2021 15:18:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157JFWe2192750;
        Mon, 7 Jun 2021 19:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=nJtRfkjbf0KaX0ytsjuDGzb2mCNFaUHYXeAhZSPQ3Ug=;
 b=cP5xGPpkzju5lcFAtfla4O/4yLyN+sl2JBTRIWDy19ykyVUVDWTmfmycuvX7aY3dcoo9
 +U4ve8gtv2zJAgbp/djTT65E0tbKUldsp/jc98EhStmF5NfOacTAzCHfMYvbgyIuXZL5
 GB9sbudg79r3oif7c4lvG54r5T7sIq1VxotP3581G8+4cxbWqPK6u8eMfL47vAfNQPds
 1QqXpIiUuTV0fg/rUgh6z/QlfM4RDD48fONPV1qpZu07gj/Y8Ufru25do8AEsZnjNvWf
 RwVyXcO1N2JGkNPxQuVpSYSeikFl/OwRQJpc/s4w51iTr2FmPw636o9LAYYLT3H6jNSO fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38yxscc0hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:15:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157JEx9J086700;
        Mon, 7 Jun 2021 19:15:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by userp3020.oracle.com with ESMTP id 390k1qbttm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 19:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juu5qqXuV3aGljngqbfGcMXm8WXbSmNTPJ2SlImNOVjMLBuzKiERGAYwLAFYlfhfA/mLZmMwzTgM/C2CuD1V2EnxnEDXC1tUvfP32PU8thQrRTh655CkBDMbMHC2vyy+UMGh3ZksvAT4P+2Vzg35xyKPABeaNsroNK4kHLthoyEcQt4ZLMn3QLZq7yMSl8+O2+e1OHA5Io5Xlx7rIlJ3OC6UfpipAa8r8Q3TKYCHq6D6oQajaD77goN0sARv+Yl0pPsSYZXeVOxpJnAXzTHYWqoDm7UnAmi2wV/gUvgp3PKYzrJrgmHFEQyJ+B8g4EUy+8EwHn1UX4p9o4z0Zp0H8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJtRfkjbf0KaX0ytsjuDGzb2mCNFaUHYXeAhZSPQ3Ug=;
 b=bPLQV9OJxxPMGkm3M4SvwS6bGpJlV3pa+JrSgduXbv1LtkwpiDjJhwVwfZYqSKByWY9dJpPv9nhzMrNvE0HVSo94WEqnmtshJXK7rhdgcdMPaEl9pqhq0XbX4j8Wz9c668rW4vmnhViWIraDTs5QH3cPhLVXrjHm2TQUdD9QVdUWa8Ovk5CKy3IokUpThyZiDlUCqFWX3em16pcOciNmlzjdYULmTq4Cui104tu3BvnzW1T6hc2YNYpVobDkN/dimIvi6cpXfR6ST3l5MnXdduuLOg00kRK6eQ5adnmVNrQJgl8GhwjkFGRQeB8+G3D7kCanZ8xd58hs7JYCsNLukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJtRfkjbf0KaX0ytsjuDGzb2mCNFaUHYXeAhZSPQ3Ug=;
 b=B/zsRPtJMDrkwrB3uR1OtV5/J6FsZydrZkvb6u1AEhJGzJkDC+dVdU6e0FW/eymgn0ggJYEAGK1Wy0iZe804/+OiqNDInGQCoAtM9+875GtLiFpjT43XTV49svLhfvRBXVg18HM0gQ7RyzP+G+3Sx/H0QDT/Bu+ssDPCY4pn3F0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 19:15:29 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::945d:d394:f2ad:2c97%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 19:15:29 +0000
Date:   Mon, 7 Jun 2021 14:15:22 -0500
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 00/22] Add AMD Secure Nested Paging
 (SEV-SNP) Guest Support
Message-ID: <YL5wSgektxdZPXZC@dt>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602140416.23573-1-brijesh.singh@amd.com>
X-Originating-IP: [138.3.201.44]
X-ClientProxiedBy: SA9PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:6e::10) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dt (138.3.201.44) by SA9PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:6e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Mon, 7 Jun 2021 19:15:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bb8bbc6-3dae-444c-08d7-08d929e89c67
X-MS-TrafficTypeDiagnostic: SA2PR10MB4459:
X-Microsoft-Antispam-PRVS: <SA2PR10MB445987B2AFF8FE0EE939277FE6389@SA2PR10MB4459.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lER2+hNTXVUmxQD6T37fPixWDPNIaf3z3gZd9ffa/68GOQmMypvdwmzByklM9LbdilNNXUaDe0+28vnyoVGfDJXtpmjJ23pI/9kF3Nvp9dUEzwPHyBx9tDDlGsiYz6ttY9EZSCQ4ngWIwKUeycGv1NpR+7qMZXAOZNZ+x3dYZEWQ4L7YCyvZPUa+U7v9JnVoaLQzyKxhDqLsCJmpid6dJ26Y5kR9jbEPydfME21mCDHxdQDDSP8jmcAFyvVE85FkxxtHej9cVjTeo+hwkvnoPaLWkRWUeilBnHh0NWofgRH53nEZDF6CCIc42uAdY4Rb5zKfIIw9k0l8YcOtQKZNEdi6m+H+tA8G71RoHrFyFP57INBl7exdM0Wwpz3h3ZoH9FDJqE6I7aJlWL8BuKC2zbiNpjfXjIDBgl3sw0drYHwFa7Ivha+fxqTc91ZpPkRUIF5kNqqIfkp/TPPq12+6YXPd2RQSCYaiaQRhn36QcUtA9Cf7/LqWRaHBhEVTgXgnhBhqpfB45McJ7CgqDR/37+yfqAUwKFEzaOdqGC3+YNtzTlvhDV2HZtsrMpyV+2M4Tu5gvmtIEH0gMtIgBAQIkCKjy3dUasX9uYIlNNzEI0soXaOXWkZkdKYTtitqfFMdiSKfUu9OuFZPDz/UY0O0zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(8676002)(66556008)(956004)(52116002)(4744005)(478600001)(66476007)(9686003)(86362001)(8936002)(316002)(2906002)(26005)(9576002)(66946007)(54906003)(5660300002)(6666004)(33716001)(6916009)(6496006)(38350700002)(186003)(16526019)(38100700002)(55016002)(44832011)(7416002)(53546011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uHKT5o5MLgFiHDk2DsQSKXZ379cjwv8EfA/EkCxf18KG7rrSn4OmtR8crBzw?=
 =?us-ascii?Q?9inNC6r2AMqSE8IcrXw+1h9KXmBOy4zjp+zKH81CN0iHhxSXub+94oHyT6QZ?=
 =?us-ascii?Q?AEe1yjh4iNZIAzFgwOAx+CCZ48pqQILsTPVp1bxvyHN3/RP5xU61h3BY8A2I?=
 =?us-ascii?Q?HRdJmVRCjEB5CC7U5l3vb0CJ79edmd2fDedNWqROfXGhsjGllkctTlBXUigS?=
 =?us-ascii?Q?bfudkew49Y4Tj37n1bgHqqyMWZ2TfR8tVB4zo+fG1VZ7dVxoCwElEpTMIn94?=
 =?us-ascii?Q?TWVgBKUyusFaC60TqtrUVCEM1aFBHiK1VQbyMRVRqmgEUPExJ7pJ9nRKh35u?=
 =?us-ascii?Q?qwisjNGg9UL9upTXM0tLvd2n3ElsqHU7opGEMfpbCxhghYdo1Aby0KuzcCZt?=
 =?us-ascii?Q?hDBF6pj8+W46Lu2B9ybxBm79C+LX8Xnh9WA5/yIzvO2PH5AUxl35aFbpdkH5?=
 =?us-ascii?Q?9Y9/m6p1GTEDOTwDizQIs+zEsHgUzWm7T05KLC4ogKNnCBRAbkaI3MCD6qFV?=
 =?us-ascii?Q?Nzbmh4mc5KYQJ1oWg2JCJQhOkddmboCUecieC1KBwKXiF4zpOVySBNOuUPxO?=
 =?us-ascii?Q?duvQl7/6K2h4s+IWHXmyiK0xJtkNdCQD5r6p16rAAUembz6iELfT/KaRNF/c?=
 =?us-ascii?Q?RpNCZpOv7mYbldP7/883f4NMYukC27bgcXFzN0Gov4bzImYm1/0Itujp47jN?=
 =?us-ascii?Q?IrYWC7zBCqbD8e2x2In69SbtFWT3UHEA5z1XV52NrSg9a1aj+gjClpnZlkCd?=
 =?us-ascii?Q?sUnDdcPXLAA9PgoKIdw029OM64nO7VXI943t67ToLeB7SG82tuKVs+WzaucJ?=
 =?us-ascii?Q?1IEwYKLTdWmqEbWZWGF/toXxSbMlzW+xqPdy+a2p+Wszk7bucGR8Gz5ewfo+?=
 =?us-ascii?Q?cpKtHDqIqzYfhQ+9Fi3pKRUNPdlF2Kwk4CG98ADUZT5VgQJULkFQEBI+yH56?=
 =?us-ascii?Q?mVAO4yTnLPWoPIr7IG/IWBnpcgGow7YN2wdrY+p/vIOO2S5OW5at0EScaj8y?=
 =?us-ascii?Q?MBiV5mbvSZ2MJ4D6hYDIWib1Z+PnycgrTdEAEz86Tk26UgPXxqLfbY+LUCPx?=
 =?us-ascii?Q?BoVGIni1C9D6Z6Sh07TyYtcv/lProOJriFhD3wAb6h1xQ179M7O/Yv6/x7W/?=
 =?us-ascii?Q?bftClG3tZM8uuEcnW1zxy9OIKxvfwkNUJyvv1KUb8L2xQlJeesYvXkwXRDMm?=
 =?us-ascii?Q?3xlfzy9RKsFQ7ILmz27cH42fr6DU3+wUfILhw2KsCxoFOOnAp5plqdqNiHeA?=
 =?us-ascii?Q?jFRvNLXisj416DCngcbutFlb+s4AWDFmiE9xGcJcO9v0QVJIaXzyES8SjGtn?=
 =?us-ascii?Q?IACSbw5nhHw2T3K9WBJyOW1+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb8bbc6-3dae-444c-08d7-08d929e89c67
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 19:15:29.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVYHBP4OexJQDpUjXivXI5+CQ6wDZUGeNBBUQ/sO9bDTYxVKWNKz6zcZxh64mSjGAY6/LHbmjI3gICJMqCLrmhDgisBF17HG1CXBEk/SuXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=973 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070131
X-Proofpoint-ORIG-GUID: t-ramXkstyB_AXsYIynEZgPdcEDu9lea
X-Proofpoint-GUID: t-ramXkstyB_AXsYIynEZgPdcEDu9lea
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070131
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-06-02 09:03:54 -0500, Brijesh Singh wrote:

[ snip ]

> The series is based on tip/master commit
>   493a0d4559fd (origin/master, origin/HEAD) Merge branch 'perf/core'

I could not find that commit (493a0d4559fd) either in
git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git repo, or in
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git repo. Which
repo can I use to apply this series?

Venu

