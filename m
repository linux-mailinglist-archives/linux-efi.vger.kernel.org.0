Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DA0483720
	for <lists+linux-efi@lfdr.de>; Mon,  3 Jan 2022 19:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiACSos (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Jan 2022 13:44:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61628 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229796AbiACSor (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Jan 2022 13:44:47 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203FVXXd003317;
        Mon, 3 Jan 2022 18:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=5i8GB1JiB288g2u8UTsiomH0qAB3JGXcADFtBwF3Ufo=;
 b=qd9DpMo7XEiiBf5iQJwZ15L0TLnGfbJ5c61SEMBcGdHoslBy3mCLwgE7CcghTdYbFo6V
 T0HzCdYNWD/VXgJHtNuDn79LDuVNNBaBWvhoIvWQmNU6H2iAgRbhiAxLodkt+nKjdCrU
 3lNfvVEAkFFG7x/9gjpuxPSUoiN8iaThIGqV0fdNwJd97Fa3PiNLCvggB+uMjwNwqECU
 M1E6Y85bfUgDlwukZo+tIfJipv5l36+Omd8UbvmeSEZjWWYrNTEeg8sDSz86ZNptcNJY
 XHpqe+f2vwLOIKZWfCJ+VUD6wWWhDKpqlb9pvqWmNIQ5Eix52fRFaL0rHZJSifPyydZv QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4gee3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 18:43:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203Iff9d159938;
        Mon, 3 Jan 2022 18:43:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3dac2v71m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 18:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No8E8yZwWswu/LI4hSD+ROzgnOuopiFM9q0Lja7A1/uFoK09mcJmXvKZkQP7RiiXhTx/nzfMx6kxtVDtbbDDakgtsU4kQi1ibKhVxIbCX8YavEWWEQV/H1gwOTi7BMvqxUlyJQ1OctAQasLjuEAlGi5yRUQOB94t6OTy9NS5ImBXbS2RYLGlafMAkUQikfq+Lw+juc5hcEXFYlAVUbgVmAnGdBFWsQHCtH82IbWJPUeH7pGb6zwfY9tdK7CyDLF6dkdhmrc3cdvdaLk2T/5NgV2800QCOMisemyslhcn+AWazrze9WRCBhzu+zB6DLKpThoo919tY1cpVD7x87jT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INRkrvTb6Hwtc55Ci8dWKP6ogGDuhKcymDgS7YyjhaM=;
 b=fVpgrfmjiFhhJALxzI+PqQvV+g4YA0AA8O7m7j1MR+yzDguQOiN7acqQ4yDoMRwtDsQQUJmYuCLEuYeeKgjfJ1ZvZXZEJdDNeeEkMOU8clXqU0y7ptp1wD6DbA3N4nt2UxYoYrp6bBYA4eZ4+9Ewi4PxZ825RQ6RBD15Ld9OLFKCY6WNk/U6hnQLzN8umgP7kNdDKx4RSCub8X9Cq8vBSPSKD1j1rPO4VpBK9lLij8kNT+XzCH+djhyN8I4VUhkqEjzunaPDlWAVVtrTKR4Bvxlrk3RrkOkyFNKZBYiCunIrTqKQrioI4+YtOIP3X8tkybjFvjOVGRxNrl6A+2GmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INRkrvTb6Hwtc55Ci8dWKP6ogGDuhKcymDgS7YyjhaM=;
 b=WUjRh6/T3sCj2ERAxklG3J+0Q22qEq5WhTClJx3sYbR6fnKdk+MSKTRN0nBeY/Qx4+taVdGzHdKLq0PihqbJUliJa1rsBsY5yYhQQIabf3hByAhNbBNXuaKOg3GPtd8/9DAK4hm7TYvZ/n1TETIPTrmO/IxjUcJVCHsm04v/3UU=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Mon, 3 Jan
 2022 18:43:54 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 18:43:54 +0000
Date:   Mon, 3 Jan 2022 12:43:46 -0600
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
Subject: Re: [PATCH v8 09/40] x86/compressed: Add helper for validating pages
 in the decompression stage
Message-ID: <YdND4m/XjX6tRo0z@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-10-brijesh.singh@amd.com>
 <Ybz3XFbThJTUySNY@dt>
 <ac5a0aac-5a48-9136-2d5d-595cb99d2a6f@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5a0aac-5a48-9136-2d5d-595cb99d2a6f@amd.com>
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82881d6-f01b-4d6f-4799-08d9cee8fe4e
X-MS-TrafficTypeDiagnostic: SA2PR10MB4795:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4795EA38C6BEC3964B448E7FE6499@SA2PR10MB4795.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLfD961GcGj9d6Ff0ov4AeuDm/PXtwUCc0TI5t0j5cTDa6l/aS8B1XQX1vFXqSxmTw/YdjfgzNFTV4pgqQ1n/IK2OwHvU1I4OYJ91uxvZhsIzm0d8XlpF38uHJ7q+WAW1ObkkR9+pMs/VbSMLPZ7ZzgtIc5GafA+a1n/VW785bjs1FzdUAYJ4N+Q+MxGRl07tKkynkhQ7L+CalGpKKuSfizsk94/+27YMn7F4uozue6QeAgtlRlkgRRGwye9ysCdv8I6YwZCBajQfQTdZ2lEVyGW+UfjhszjtUKkDdAHqCmXIfYEfDeF6CmYkwU6dfGa/vcKlgDby1Y9A8Cnjh9iEVd3NIusYYVeJG66hQDW8+s9DnhkLWZuw0DcpAmRpPM/JqlrwHDG9JhFX6kEOuwX3IxnryoLfc+UnwntYbYheroQCm48oLlA2TRGA4pDxvo8k3RNRmSDKwNH3XYMBa5udqxSSXbIBft7JeCjjcA41a6If4TCS+8jCPH30DG1JMn/m6S0C2OSy/bkxdV8wMNl3DlWOgkensxqXpk/+SpY/4DI94NaLYUKy5rmvFffcvjhH8Ac6oQ5R9Q7e2lAQFQeZdi4tTs1Q6m9siC+wclQ/GLjOfKqREd457hXeZy2ITshnFzUezwo9lR0fUPKRs/pTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(53546011)(186003)(26005)(6916009)(2906002)(44832011)(5660300002)(83380400001)(316002)(4326008)(66556008)(4001150100001)(6486002)(6666004)(6512007)(508600001)(86362001)(9686003)(33716001)(54906003)(38100700002)(66476007)(66946007)(7416002)(7406005)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Hi4mbMGf4bH4QO41TBypknlH/r8/N5SZ4uUEXSdNmAU5deXJDjSk/3lniG?=
 =?iso-8859-1?Q?o+j/9ws+Rz9LDR0IO05v5M5Iaha8M8+12i8Hu5vbMX2evZljjulHw8PbhB?=
 =?iso-8859-1?Q?ixngrvP8TWIfSlNf172zW2DeL53kZYK7EMg7/wiPi6tLXpu0aVuvIoFQ5q?=
 =?iso-8859-1?Q?9od/Fqs9rG/QpaX7gLFZH2fvoetzxxEA/ws1NQF1eIBqzmPl/MG67nm4SI?=
 =?iso-8859-1?Q?ZYHxX4jwzcE6k8/o3XTA/fgSODkCeoGulWWzvI+5seBN/fsKYDG2X/+WyM?=
 =?iso-8859-1?Q?LimvnK93yhKMalzsUAG3btIhaFyHJrQeX1BVyufnOJDinFUyTvWn6ks/Fy?=
 =?iso-8859-1?Q?KSmGZzoy6bDexvrz+394wq3qNdJ1QbjrlIUAqWbWvkUtoEn3PDdsI34i/K?=
 =?iso-8859-1?Q?Z/fvSvH6UZlEXT/CYzZRNa/00t/upDmfSGSOame55ZvNI6sM41PysC0XaQ?=
 =?iso-8859-1?Q?YOioZpqSx+7ZTivnBcCDUV1Z+XVcl9r2+PpRfJiimPXPBf5pu5BujHFSTI?=
 =?iso-8859-1?Q?D0GKyXM3KjsESB5vATJzxjBVQc8xBNVCCNl502Rig4Bpny0UIKXLK5BLEi?=
 =?iso-8859-1?Q?jdrfjCMx6WwEtF+plLgfrDFK2cg/mTvlHnV69L/23mSVFMbDCOBwnhtnSX?=
 =?iso-8859-1?Q?mYp4SHb6cMj6O1PJ0rE6XNXSOauM8F1IkU9swewbfkc+5w33meWxvq+XDv?=
 =?iso-8859-1?Q?PdtPBMgrqYbqGrcRaZVPBEkQLAvkl5mKN9WPeihvZ3y7c3ARiuqMOmRjvc?=
 =?iso-8859-1?Q?w68Vc81S+0m9vES8bOXmKDQx1U1FbR+ulF35RgNl9S0SLhHZhNRlJSvCcE?=
 =?iso-8859-1?Q?ndfAU7pe2fNHEZrvTGFuqAL8o8LbIUU3gtD/CLQpY71atdeYww+Y4BQ+KU?=
 =?iso-8859-1?Q?+Zv59g5ZuvZZAKzBTh4r/wbawTkBkw53kDr8Dj5NamDJXaI9z5wLCD5cMk?=
 =?iso-8859-1?Q?+odBv+wzVtO2DJ4bVOq+V+NksmogX8afpbYc0aiJ3pjTzhri3rP2JyTPkI?=
 =?iso-8859-1?Q?wZMRRNmDnFsS/BgMXWsP80XbQ340Ovf/y/AnRrrIuOH4o5EKPpDxegDIBJ?=
 =?iso-8859-1?Q?gyRs+zs1xFnQ3S8mOYBZkStFxG1owzfZgw6VQppTVpuc433BfUvamTPdXt?=
 =?iso-8859-1?Q?5pkHfoxszCwb8WsiFm0m+Ck8CusA39PVUjwEamuivYGzjncO85WRFWYAX+?=
 =?iso-8859-1?Q?JHUqQ4z8Z4KbLrgoXVbFwSlWkLDOGl9VbLmTFBS/eo8OzHudfTbaWt8+T7?=
 =?iso-8859-1?Q?b6Ks0637HI5Bly1o8iqCfQr84bHwZtUOP22nKJXQ/egvdGJtBTr4Ex4Aus?=
 =?iso-8859-1?Q?/Ytq4ULo07NelThkYydk1RhiP9OyRNw36aElChfKBPGm0zGBm6sEJVoBDG?=
 =?iso-8859-1?Q?D6pqE7CIZbyhLfnQXe2gVolMWMBO8EAWykxB1E9SRfjY4+LwqKl53PQh4p?=
 =?iso-8859-1?Q?F6pmlIx3gZPZcWWtvyyCMfXo7EuUhfumnYq611Pks55S2uVVDvxCCVRUGD?=
 =?iso-8859-1?Q?ca9WwtmOfEbJXZQSqooIb3/Jklm1ImHOAUvQPQTIxJW3UHU/PHFhW3D3no?=
 =?iso-8859-1?Q?1xzXIoKkDtsnLvao9wwqHwhHIr/S9U6j936Auo3//6yvKmm6S9m6y2GqZu?=
 =?iso-8859-1?Q?/o0FeiAgms63b895BKDXHE4cilC1zCZg6WZtDuGKeSyw83Rj7N7pcjuVEH?=
 =?iso-8859-1?Q?nwhOnBB9y9yKprXLeY+b/vkrhpvPzIobRMC37lq+AXozs8p3+1YW3gCj9C?=
 =?iso-8859-1?Q?UVNQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82881d6-f01b-4d6f-4799-08d9cee8fe4e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 18:43:54.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiDltEYKMngxvVPV5Tbch8OxvzmK9218QxzT9Vj2skcHBVzV+pGxW8dNuGq5K7WT80dooiOuIJm2QOoVgZuAvVtSgg9d/7t1tpjwhMnP3jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030127
X-Proofpoint-GUID: JkUwarGoaDsxvF2DHlHjUXTclA17_ZLz
X-Proofpoint-ORIG-GUID: JkUwarGoaDsxvF2DHlHjUXTclA17_ZLz
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-17 17:24:43 -0600, Brijesh Singh wrote:
> 
> On 12/17/21 2:47 PM, Venu Busireddy wrote:
> 
> >>  	 * the caches.
> >>  	 */
> >> -	if ((set | clr) & _PAGE_ENC)
> >> +	if ((set | clr) & _PAGE_ENC) {
> >>  		clflush_page(address);
> >>  
> >> +		/*
> >> +		 * If the encryption attribute is being cleared, then change
> >> +		 * the page state to shared in the RMP table.
> >> +		 */
> >> +		if (clr)
> > This function is also called by set_page_non_present() with clr set to
> > _PAGE_PRESENT. Do we want to change the page state to shared even when
> > the page is not present? If not, shouldn't the check be (clr & _PAGE_ENC)?
> 
> I am not able to follow your comment. Here we only pay attention to the
> encryption attribute, if encryption attribute is getting cleared then
> make PSC. In the case ov set_page_non_present(), the outer if() block
> will return false.  Am I missing something ?

You are right. I missed the outer check.

> > The page is not "added", right? Shouldn't we just say:
> 
> Technically, PSC modifies the RMP entry, so I should use that  instead
> of calling "added".
> 
> 
> >     Validate the page so that it is consistent with the RMP entry.
> 
> Yes, I am okay with it.

Thanks,

Venu
