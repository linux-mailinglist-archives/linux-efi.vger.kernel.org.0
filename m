Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88094858B5
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jan 2022 19:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbiAESzN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 5 Jan 2022 13:55:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56842 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbiAESzL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 5 Jan 2022 13:55:11 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205Ii9Fs008248;
        Wed, 5 Jan 2022 18:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lpjtdUyjBYmwRh+vLkoU4AeemHv3f9xhPl5IkY+cQaA=;
 b=FRL/gv23WVfAnONqDiQsJTAG3gZbAfP3D4GFsTCdSYojt+6/66RvMtl67YRKg5ELuOvP
 3S8DEiuceGY4vPyP6hpYJQZOLKF5TkdvqgNac1x5ACXeH+JabJoWRPqxrfrYRClHAVbC
 cXu1vhriTvuQ82z/X+Ndlyg7Xlxm7XtJYfTantHihaWfFp+8t4HHzOccqn6zz97vX9c7
 mPlsBCtmhLlb5TEhUB0vrP3yDEXuHbtNEvieYTngMF0gYq03CNYLs9ax+1Hp7M8d+oeC
 MMJyAHS7Qhfv/K9WPv4TTrnLGNhJaRw85sO9i+RnOJGJUkziWmQk1IakoKSTqSNx6C2d ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st5pbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 18:54:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205Ipnq1004317;
        Wed, 5 Jan 2022 18:54:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3dac2ytqw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 18:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcnyOdtp0B0tEPLU9d2GfYRdJvDz5husooERsrwVcyj5oBByMZ/f+2JuefKoYQvkkas24+xvaclyNZOPY9PbI41nvgJ2QVzKepyOlhslDGWUKUQH8IRZp846c+jCsoLy4mJknndgfn7pWkt//cTgLqp8zao5BF816mKkLFIbI49w7gGWaUVzxbJxgHJx/2DntLpdOLoQMD1tRg/FudtX3jwqUBRzA/Ogip0w0UuiTsIqpw7jkrmtpb4S1kRKvxLcSmX/sXgJwppf47CL/S37nW7TW7qPr3csA0p/JE9pjLQKCTK85Cfy9iE2LF8o+fq4c2OBWjgYXdsHJgA4PNb9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpjtdUyjBYmwRh+vLkoU4AeemHv3f9xhPl5IkY+cQaA=;
 b=VGFruCzyM6v1NfEyiU9jiPNSORgszCMfxY5zSRyBgw6ZtuzKaYzWKJK+NZcJfSA0l01GN1qFSaiZ8zKZjjrSl6czS1ZNoa06JcbdihojoJBcVbX+TyEO/u32xj3avorBdsLx0yl5TuU4I2WSw3JqTIP+8Og2AQU5X8HptF8h+BEIDRh9Uojzq17TNF6zM1W7ODE6xgYyNOyTaoNtOp6Vvou+0dYI2uUviP5dQMrh+Tz7XOY75caAUx6SFmlVb9TB2lY8CIbylAhLrnYyXnvqGep9yr5k1aG1IqQITbnpo/485BN+XmU2/A9E9CqVkrc9pftr/HelqSG21DnsDkMlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpjtdUyjBYmwRh+vLkoU4AeemHv3f9xhPl5IkY+cQaA=;
 b=gt5QFm7nUzUpskZGKHFsholkJAJpn+4BMuPjNVAWlUFdtudSQmPTFmefj76gAAtviz/G4hEaU6WX+IGS2pP0L7VRn8Rmiezv2mnL5pPtaN2VIYeEvWPZ9Uo9LLIh8I9viS4nH7HfHIeP+427YH7hGo3Z4JOOi5CpLTJFCMwafxo=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA1PR10MB5511.namprd10.prod.outlook.com (2603:10b6:806:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 18:54:39 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 18:54:39 +0000
Date:   Wed, 5 Jan 2022 12:54:34 -0600
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
Subject: Re: [PATCH v8 19/40] KVM: SVM: Update the SEV-ES save area mapping
Message-ID: <YdXpapl9MMKb6H68@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-20-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-20-brijesh.singh@amd.com>
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 321fcb2d-a93b-4920-d631-08d9d07cd3a7
X-MS-TrafficTypeDiagnostic: SA1PR10MB5511:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB5511FD9B942CD1F0729F112AE64B9@SA1PR10MB5511.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /a3LAPARJ3aIDgzk3RToPW6fbPPreq8a7xyfmYRFoECQQ94yQ/ralmG5SxTt1qKTnTD8MuI1JOV6JJf8XyRshjwchy7omF+/sWg+94XZT3IKeiR28o0stgiNpK7y346K6CF1Snr4OW7JwGS4N9IAAnfn3RdHHIOwLl3wjUmCf4aEdFd+Pj9W9CSbe+PlU8OK0hyItc3OKLU/1FlaHZPbJy0j/Jgu4Z361eHyFyR9Ubs0CVqx+Zx+GSX+RJyg2skjGw19PT44L5T3Mrfe5kdsN1pAgV+ekPxheYWda+8r0vktHs1wBm3yo21XYpZnqs3GWHhd/IOmphs4J+3xQh+3Z+MxlaD5bwTRFcDgKKgFi9jwFS8gXVwMfQ5Zxc/aEnQDr48P+dtQX1DC4zBSNiiKKsXo6hqcQu84z6Pn9jHGsXbwSPgDfB1aAHnOInZV07lMuHp+JHAAdlu0fLMC9J8Mwe5yKBifocG7FIt1WosCm0DAMED3NkBdFU4XXBFW/SkZ8H1MuChKhVjIAKjOcNLhDgqFg/pvg72vuFHJun9+t8Ef0t6tXOhaiCnRaZ8Bi2GRxY3rWoaUj6uy98C9YdV6cgReqSW+RS0Zq2yx7M01tzL2utFVOq4g2NUvIVFpfhJMyN4eMwYoRbPyqDi5N4x60Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(15650500001)(6486002)(7416002)(7406005)(508600001)(6666004)(2906002)(186003)(26005)(38100700002)(8676002)(4326008)(9686003)(4001150100001)(6512007)(66946007)(66556008)(8936002)(44832011)(53546011)(86362001)(66476007)(6506007)(83380400001)(33716001)(6916009)(4744005)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3l2yyO0bEqcTnd6PlKD1CaqOqNI/7EjL9wzrGHAO1lNYA6MRyCAqMI/1KRT?=
 =?us-ascii?Q?kuWfRVSWA4lL6/vK0ldBD5bmgzsOefNg4/n1GyJIVSVpe7wkkOir6Dhjx2JS?=
 =?us-ascii?Q?4Ul8DKSCF83onwgg+DRCrxr6znM7kXYRmjpd7q7bo/G7/G4eRy+FGNOSfHOV?=
 =?us-ascii?Q?UusBA93MF0utrunhEov56eKT179SoHZmU7U+qNQLC0kvhfErQ60xqbXNWqu8?=
 =?us-ascii?Q?7hs3SX5AczlGRPkJsbeOM90LTGOhmcSO114AV/DvPE+YwH7KpmctZKPDlQJf?=
 =?us-ascii?Q?bBT4FT55E27LIcMRibTI+zc1n6+uhWnkf4Jdjx9iLE/nV0eU9G+QR7GHzHh/?=
 =?us-ascii?Q?M6FgjFTuXcc3QnxGeiG+jVUfnVvkzIPEYKhrmJojxQ05TV8nTwACHHqmUaRr?=
 =?us-ascii?Q?0dxPiaWKryIUTuEp6m7S8pLbvHbvByjHkQg+rKPbim1w63nZ6Z9mroSGDh3X?=
 =?us-ascii?Q?GVx9blt4TRT4QbKyYkEksX+JKknCWtSKvehiRH03YZ/YS7IjnQfD39IoOVTo?=
 =?us-ascii?Q?4m59++RXsYr31as4cQdKGnt4qSahwelGd+jV5iDtH+KQlWhLc21U40RqJO7i?=
 =?us-ascii?Q?yIz0QnLUw+Y6LzZlmUc6k5HQgaz85VqQkf//XRHZB7rnuRjR4Msa/28jomLo?=
 =?us-ascii?Q?svx+nFHnxTWiHAVPIHqfleWw2oLScLCkJhW3ACBcEHoSPIUQ8REz668dOh1A?=
 =?us-ascii?Q?We4rI7m+UwvPqtf+02pSLfcQRu52woWlbrQYb1NFhhDBkgIL28nu0GrYxODm?=
 =?us-ascii?Q?PQSNgbwnC5Rmf0JPR78ahOJBp2nxlw2RvRoMUL9BbidS55vg52SwfUVn3rzI?=
 =?us-ascii?Q?qg+JvRv6XReropdbGUQaliSgMxnn0Fmx99Gc6x1gfbzxnzYoLzn7ZSePJAYQ?=
 =?us-ascii?Q?nUR4K0W18f22UCKMahhQSHj56R3mgUs/8y3s3ELNadNELYaucZspoQ5Me1TX?=
 =?us-ascii?Q?L6cEUzfEz8hlqN8YF5tv6B1bjKjXTQTtRXBawPygVyXU0xVryLATeLTh//Xr?=
 =?us-ascii?Q?tsT0KuObv/9XmPBk5eaBPmyZIcTCt1cRhwVRLWBJgFKAPTz3TGfeCqkv6VRY?=
 =?us-ascii?Q?FI0GcMnM2N6F6PZd891XFOfUvdu8lw5B+5fxmTBMk+Mjlk0CqMy+j4pWh3a/?=
 =?us-ascii?Q?1h4aBBvRWoHpn3uld/gFKTHmuPyVb079MSYgh+dtMOLM7keOeMF5yLmWLrkW?=
 =?us-ascii?Q?uqnrlnZi+BNO7Z5xwqrxGBE57b0vTCfA5/e2oOFTDWO4bEbxZs4gzI+d2oJT?=
 =?us-ascii?Q?DImcbKp1WNeUpayfpsKRlvMVczumHPSY4k3TXkaR2VPi4XuNwB7tI75WfPtN?=
 =?us-ascii?Q?kRj/q52bVaqR6RfHTbvqqY0W375Wr+bY4Rv5AXP4oILYyUQMpiuCMEfPfeFh?=
 =?us-ascii?Q?aR8IxoVg58T2KNopdm/qde3J5j1cK2dsYcUfeiS9OIOYJBJ0j2hKG4nh1hGY?=
 =?us-ascii?Q?3KlIDeZDDC6d+uMkQ6dI7aBtpb6ZEaiWInJQYvc6N1MyvO+mkI2FnqA+gN+R?=
 =?us-ascii?Q?u985y56ZNo+AqpmVabhSGEpLryiEq0DTTZOQF6GnZCIE2kTdlFkClPFDUSov?=
 =?us-ascii?Q?Yt70KON6GpAsBmpgmNm8wZU19GD1rLyCwbkjeZJUhEbm71uQerkizbw8ZRoA?=
 =?us-ascii?Q?EOYyq7riInmIzaNdI9wSSsPW5CsFO7gUXk17vP/x5BQ2nPnSNmQ7xwrT6V0l?=
 =?us-ascii?Q?cPmn6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321fcb2d-a93b-4920-d631-08d9d07cd3a7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 18:54:39.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dflt1ouX2z8WnAoO+Q39N2V+fB0r1+rJIDHoAdeqIhTakKsJUyhRE8PbA7gBtevA8dXumndlZPKNxVYWcQOrHStVLJgAcudNCJyjB2GemI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5511
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050121
X-Proofpoint-GUID: dpA_8y2WaHjZT0fz-VbkKra7F450xeZf
X-Proofpoint-ORIG-GUID: dpA_8y2WaHjZT0fz-VbkKra7F450xeZf
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:11 -0600, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> This is the final step in defining the multiple save areas to keep them
> separate and ensuring proper operation amongst the different types of
> guests. Update the SEV-ES/SEV-SNP save area to match the APM. This save
> area will be used for the upcoming SEV-SNP AP Creation NAE event support.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

> ---
>  arch/x86/include/asm/svm.h | 66 +++++++++++++++++++++++++++++---------
>  1 file changed, 50 insertions(+), 16 deletions(-)
> 
