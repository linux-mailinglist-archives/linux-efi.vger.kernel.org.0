Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD048589D
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiAESmH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 13:42:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37604 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243158AbiAESmC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 13:42:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205ILLiY005145;
        Wed, 5 Jan 2022 18:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0Z2s9qFswC3rfSktebUvbwH/JCgV2vD34hKgsAV886k=;
 b=uPYQL9iLX4btcXGUofjg4waHdUBxsMTMb1rwzox+8/R4FWovwtWOKT47HFXYUeslpOw5
 Ryew066k/eHpLuB62kPXC41viKiH3ODTq3L3Fq3X/f3XUONdUgkIlFRXsJxOs7C0DRfO
 3ekdqR20D7B/VNF+tZDKuNIMsL1CDn7Dpaap/Mojf7QJJTiFAldtL5wYnwjlwf2Z0cHk
 Jfy6qcXhFAjuGTT8sSQfSSPv4W92IbttH1IgpXTi5TlScX3XUXO6GZdrcAkof9KoGgML
 bbYnHKWhYRSw0yz0aao8vABVfr7yYErQS7rsgxZVssoxRcvow/HCX7utFbSsIJm77Dt+ Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fngmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 18:41:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205IFek7053659;
        Wed, 5 Jan 2022 18:41:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3daes5kew7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 18:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGAeJn0sOdAOlxc6WAtcA/JDcfd2jecbfArlZE6Ta5NBSKzeLdb0bj36RcFfwWDb1nMar4czEp2viDSkB0CPh/hcZQl8YDK+e1xXXYT3V9o54+rXNaCa+APJYkLhJjhwrJopD8cugqD9K4Z3JdvMIIzC8UhkwswwKVj5rR00M4jU9pwe+jGWHb+aAgcHOogca9MLDv1KmMbIMCJKiM5BpZvoM6bYZcd8J9eS+/GZMmw1NkbHphvjbY6AZFPuNoHeBlRldKdSzS6lu5WeDO33C1/bJQxoihiPPFfZz0F/IERfFW8gQ4f9oWk61l4h+7siU8sIPLlVQyYE1kqn1KVZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z2s9qFswC3rfSktebUvbwH/JCgV2vD34hKgsAV886k=;
 b=V/A9azCGp15pESWsIVKOueJTptuGzoPbVPjd1kGeR+YaeF4yC4yRX1c+lGok47D7VdS9Duh9JISBNsIKYspHTg/ECaW3mz0wtrKpvz9nin7NqZMkGbRIqd/tnwYXgl4lCRngVoTI2DKldep3ByzY3STGw0VRCfMJJ9IPgkxNy5eTTcvugx+06rALEQ7YZ5mLvohExufh5m8Mmpyp/sGZ6sr+wZF9bSZJ5VHX0/2RJsTo/EtFGEDAEMJZWGKnta7ipRNSPPgOyjAmYT6LGN3KuITnC+zKHmOqbpO54yRIMtpWoJoTBCLr5P8d6r4QCKEmpH7bRek6Vlb718vKlQmJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z2s9qFswC3rfSktebUvbwH/JCgV2vD34hKgsAV886k=;
 b=MaEed9mwo3rf2Ql3tCdtZ0ro621h0EFpYa7YbBjfk0voCylFyuS8pCz1YA8IkLbexp4FP97Q4Jz/B1Utu5aoFCqlKNy9ri/tTcAJixAEMo2N8DQbZdiRJPDZzBeWciDPtuJhfbIbsIuo0hwNjtFrtFXZsEu5Q3umOc9SDdngj5Y=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2702.namprd10.prod.outlook.com (2603:10b6:805:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 18:41:27 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 18:41:27 +0000
Date:   Wed, 5 Jan 2022 12:41:20 -0600
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
Subject: Re: [PATCH v8 18/40] KVM: SVM: Create a separate mapping for the
 GHCB save area
Message-ID: <YdXmUBHFytjrpZuY@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-19-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-19-brijesh.singh@amd.com>
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce17f64-7bd3-48bf-9178-08d9d07afb14
X-MS-TrafficTypeDiagnostic: SN6PR10MB2702:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2702FB01C77A2D1667633079E64B9@SN6PR10MB2702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L0/33ecekx4LzSVW8FRIntloB+SF16bTDmVihnCUhP1ISdQWhouOAJzpGjsBhI6vjzVrsfeidP/QiYP7h8OiOTak2p4HJBGmDkVYZuS3c5WXlffYnAjypi9aYTjtg64Par8LOjX/+c7pPdyLiEWzbN9XK89udcI6Ul4GrTAeQMjJYW+y70iKG6Lrv+87BkXmZBNVz0R+jxaXOrN9DHKRrhxmGVVyJFopy+entzl2Y0ZsgbdKn7GtSYiK3fbCnR+8hgQzijNobcD/iKapy81uxUyRrvsplV/TPZAZcNb5Q9xCk1bcoCsHtTGXezG60q20M/tN4Y3QZt2QmIYGQE/vCXWJmHsGEdZp+hfTPTPvM65mZqZWWZcvyg7Jh+HqZq2T+lh84BvrBfbsjPzpP5GNhLLbOhdbd+dMSYl22O7qzCQyyN+NftVHzt4SI5USpz17b94YAvMl4VXNwYLzdLwZadmK2gEpsXTUz5xfZy7Mdev6PdBdvwuwgtk0kZN7b5EsOXmPaowBHpxSYmgxOqguxcAiSZQO2mCllvvEYrleCk/40JeQ3Krar7VE4plDNrsLac6g9Q9ot5Wo/YHGsKaW2soEP4r6hZv1V9gaPZMGuGy9l8daG+5q04l+xbdQC7FbNLOeICC3ERfO86oDlKBXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(316002)(5660300002)(44832011)(8936002)(6916009)(26005)(83380400001)(4001150100001)(33716001)(86362001)(53546011)(7416002)(7406005)(9686003)(4326008)(6486002)(66946007)(8676002)(4744005)(6666004)(6512007)(66556008)(2906002)(38100700002)(6506007)(66476007)(508600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0V4NlFIEraBoTy5hpGuYGw/2WyAu+qqqsrHQxukfZhkP0acTvU/zXedvtHiF?=
 =?us-ascii?Q?eLBgLiX863y73TTm1n3yr9ZbsVqrQram4Bd/6Ct8bUgh16so6e8ZMWaBKMOj?=
 =?us-ascii?Q?YUzW/WJ8GxQUdlz+G98rhYWbwCz+rGuJ/N+JsVLbGjyFhJWzPCJbSX/SYzeo?=
 =?us-ascii?Q?k8z2QQiwbCQ2/lWzkwTCfPTcuU3KIlGPQOx6+k8g1SX6PqG+vkCALdhqpVks?=
 =?us-ascii?Q?C8lWeb0NgL/Bw4W6EZFt1Lzbs/yRKSwe7H6nS8thlM455D5Yc9EP7ooqIPtK?=
 =?us-ascii?Q?T/5wYyUyUGONVTsFgS9CYXw7jMsCLMQo0B8+uQs3iYa5Ipfaj0R5Tz/nqDqB?=
 =?us-ascii?Q?qzKbVS5ixG1VCXrR20GU4kdYmXePXl+vYFW6oi4aMKVowbh680KFgdLYQ7bw?=
 =?us-ascii?Q?5A1+Ow9VSoy789pNOq27B+HCBLMNZLXlHWshYkE2Ivcv/EHMi9m0xg6u2Y3H?=
 =?us-ascii?Q?ccIdpyHEqoQcAKOLdaKccD0wFQfE8z6Y7EEq2J4ez57vBpBR8CUeHbU6nYH9?=
 =?us-ascii?Q?TstpZOQBPuAYnmY6Ozb322sQeHZS01I7WePK7PUIWVTXmuOakE4uqCpgD2wx?=
 =?us-ascii?Q?3BraWqQ0AGJipZj+yXNg/KDpySYrqjeGCPdFYc6+5gbgca5rqMAoy6iY1N8w?=
 =?us-ascii?Q?hLZb2N4ZYYUgz5bzfeoYKZHumAT1+7soDyC6sQRnWQ6puXYwKOo3lYglO2f7?=
 =?us-ascii?Q?nFhBWEPOfVL7MrQFzf1qHA8HvxzdUuhs5TZL2YUvRuDRTNLflhNlgx79Cgqj?=
 =?us-ascii?Q?fb1ZSqt+xDVa0ybf3hCIlEGBGZv41Uza5wSCAeNRl4JV0eic+JJnbUIn50w2?=
 =?us-ascii?Q?B+/rGM9KROeTCoUHWoq009pNrxxoTF0mQCjKqKHGTS50iyU2fqjJmUbKz1Zc?=
 =?us-ascii?Q?oHZFy9AAAP1nfEBpVk0ibVNPQ8J02nYenCY6RleKw47mnRIBOHhNiG6j4+s8?=
 =?us-ascii?Q?aQWeP64opADz+RrAZreRFvjhF9/7pe0RQU9H0hI8lTMEqSoV9PPTYOwBex18?=
 =?us-ascii?Q?f2LxlKGCUGftxYP1XOG7Ufl9eSl5Xc2cI7E1mYAQAwRtb5Q06bPQUfkN9VjJ?=
 =?us-ascii?Q?U6896WvlQyhcthud0sSC5TTo75OFu7JlfAK05HAEQEdBJlCcL/R1nMkuMg+T?=
 =?us-ascii?Q?yPC8F10kZO/yXVCEkdtbN7ibgy7Q/LcJzpriRqPslwxj9NZQ1WuL4qtJKbVB?=
 =?us-ascii?Q?NbI4K6ETBFSkSdo5dzKarbrZAVygqS+SjueUg7A6eDDBeDcd61n7s94ilgIY?=
 =?us-ascii?Q?Pm/52SoV0p5AFNDBcq+6wyiPG6JACO7SVcQUjkHBYvrq57RBKTfCvmjE7cFO?=
 =?us-ascii?Q?Qpn+Mmw6p8QrEMRb1SNtSAoxw7epReKxAvBPhheMnhk6VB1TCNt3aqDtv7Ur?=
 =?us-ascii?Q?QcbRkqeAObKvwctUlIvBotd9IJEHkARZIQBPKlzRpmwCNzBN8A+a9FI3m/eh?=
 =?us-ascii?Q?vPVMqs8MlJ0AQlLJ17BXN+ujp6X4I/5ri/lSUjwQ4Ty6aqklA97JHi8voccW?=
 =?us-ascii?Q?/eK19/ehEYT2l8CJMHUwVBbPgb3szKsEQJBZFu+BTUapAoKNg7bmbnLNPD49?=
 =?us-ascii?Q?Dm6+CMneH8azmpck9n6Hzpbsoa5M+HKevKfA80cJQlQTX0+q+DXvY6LnER0X?=
 =?us-ascii?Q?C5Vj93rAiT416z/bM3tB91Hqp2B6jXPA9cT9QMPG6Zxkx5zt5jB5b4YKISPj?=
 =?us-ascii?Q?WrbYog=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce17f64-7bd3-48bf-9178-08d9d07afb14
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 18:41:26.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bnq8hK3T1WZulPYkuS8IDgDrunZzNnOCtFc1BrdnVCzQmno/wWvrSMhDb0EA2TYMuM3EeSuN90+I4sUW8x/XdW8/uqWnhcVtrv//nxpnmHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2702
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050119
X-Proofpoint-ORIG-GUID: VgtPoetv1a6-v94L3EnkmPAqreWd6QyK
X-Proofpoint-GUID: VgtPoetv1a6-v94L3EnkmPAqreWd6QyK
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:10 -0600, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> The initial implementation of the GHCB spec was based on trying to keep
> the register state offsets the same relative to the VM save area. However,
> the save area for SEV-ES has changed within the hardware causing the
> relation between the SEV-ES save area to change relative to the GHCB save
> area.
> 
> This is the second step in defining the multiple save areas to keep them
> separate and ensuring proper operation amongst the different types of
> guests. Create a GHCB save area that matches the GHCB specification.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/svm.h | 48 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
