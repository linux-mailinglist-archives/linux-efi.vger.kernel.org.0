Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931C05B26B5
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 21:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiIHT3z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiIHT3x (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 15:29:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F61613DED;
        Thu,  8 Sep 2022 12:29:51 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288JGgSZ031350;
        Thu, 8 Sep 2022 19:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XB8wq8cmJM3W2D3bgGyLOpFPHA6N5NVNF91TxaAI+Bw=;
 b=fkM+7ixS5mOnOm+BtRuSbY3ZT6Gpq9BpqwSsVa5B0+bbDFKrR5E19L2NI+KkWhub56n+
 uu4Xy2/kxOUiq9ncgE+WsF/QH4cef59ervtUKxnD1DuvowAxfyyfnA7iIeBShyWCUx2A
 fFw/9JHn32bHEJrbCeK1StNa1YLuGVPblssgYU/22J6goDwpS+HeHLKPaKQEok/6Im7x
 Byub8qop3LlT6IRUwqaDlGsv5d40lNX9rtaD1AK7kxYMZQPdx8NsfhkpjoN+Txvp3c7r
 ECECxku9q7+Gp48LvOx2rTQqV53TY2Wo7M8tms4XfCBe0hl1xfBNK6sNGmADWL2oayFB Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfpdnrd2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 19:28:52 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 288JI54T036616;
        Thu, 8 Sep 2022 19:28:51 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfpdnrd1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 19:28:51 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 288JNUuO011438;
        Thu, 8 Sep 2022 19:28:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3jbx6hw72v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 19:28:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 288JPDSv33423776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 19:25:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CB4AE045;
        Thu,  8 Sep 2022 19:28:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87EFDAE04D;
        Thu,  8 Sep 2022 19:28:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.32.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Sep 2022 19:28:43 +0000 (GMT)
Date:   Thu, 8 Sep 2022 22:28:41 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Message-ID: <YxpCaQARczhZQmq2@linux.ibm.com>
References: <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <20220810141959.ictqchz7josyd7pt@techsingularity.net>
 <CAAH4kHa6s3sBRySNu-TZG_6vOaN4KheVy4kvxG5s=wOTDGy2=Q@mail.gmail.com>
 <2981e25e-9cda-518a-9750-b8694f2356b5@amd.com>
 <CAAH4kHbcfnVWNQHf6Mrg__bSFT6196Sx4kno6o0Zo7hsgOgnNw@mail.gmail.com>
 <984e07ed-914f-93ca-a141-3fc8677878e0@intel.com>
 <CAAH4kHawguTEuDVyz1ysSbH0X_mT=SvxLi=UhwEzXM0abbWefg@mail.gmail.com>
 <YxncAElGrPEGRYg1@linux.ibm.com>
 <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4kHaP8JUh0Z4rF83=2RZTGMATT5MHot6rAnAwt79PL64mVQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nN1RgLu1rMJ3m3ZEc6DjIOZxZ6m46gbw
X-Proofpoint-GUID: lBIoRw29rMgak1wV_9EoP1zBzLH4qjei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_11,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 08, 2022 at 09:23:07AM -0700, Dionna Amalie Glaze wrote:
> >
> > Looks like the first access to the memory map fails, although I think
> > it's not in INIT_LIST_HEAD() but rather in init_page_count().
> >
> > I'd start with making sure that page_alloc::memmap_alloc() actually returns
> > accepted memory. If you build kernel with CONFIG_DEBUG_VM=y the memory map
> > will poisoned in this function, so my guess is it'd crash there.
> >
> 
> That's a wonderful hint, thank you! I did not run this test
> CONFIG_DEBUG_VM set, but you think it's possible it could still be
> here?

It depends on how you configured your kernel. Say, defconfig does not set
it.

-- 
Sincerely yours,
Mike.
