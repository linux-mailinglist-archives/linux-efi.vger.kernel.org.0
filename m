Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B234A5F0B
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbiBAPGY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 10:06:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239789AbiBAPGW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 10:06:22 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211DIYYN015638;
        Tue, 1 Feb 2022 15:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=ToXTNfkMZFKaX0cR4GMzptBPMUOwrlwYms0kQCUHCRw=;
 b=WsAingg9xeS+2pWFI8eCa6N9KwIknymFrNib35nGQrZZGkokpZU5sRkpR2+THZ/qUq9B
 yXisj7SGzKP0IlrHkLDm03amKAPIo4nRMNxx6L00kVqFfXgVoq75ZYOlXFgESywshyRq
 OM3ctwRmNoS9SA6WvyBHMSRLsvhNUyZimZ8R5w7uTfhasZACl9vGbQhfBiae4Wjvxp/9
 SaizqSTl8jZS/EK98AMSTfe0WOKjmqY9HNaNCXX+cvR6fNqgjxo5l2N1VqjY/vCUcz66
 5ApuNpgTbiI2fK4GYVYXmg/EBoOnJj/m4mTq+8Hq2K+/CgZb0/GY1+Z268LriHYp6NDg VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dy2rudv05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 15:05:20 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211EuH4D014152;
        Tue, 1 Feb 2022 15:05:20 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dy2ruduy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 15:05:19 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211F2NVs002911;
        Tue, 1 Feb 2022 15:05:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 3dvw7atq34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 15:05:18 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211F5EBa35979592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 15:05:14 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E73B78072;
        Tue,  1 Feb 2022 15:05:14 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3AEB78064;
        Tue,  1 Feb 2022 15:05:09 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.75.243])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 15:05:09 +0000 (GMT)
Message-ID: <936285f4de4520c1fa9e594ca5e912ea766c127b.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        dougmill@linux.vnet.ibm.com, gcwilson@linux.ibm.com,
        gjoyce@ibm.com, linuxppc-dev@lists.ozlabs.org, mjg59@srcf.ucam.org,
        mpe@ellerman.id.au, dja@axtens.net
Date:   Tue, 01 Feb 2022 10:05:08 -0500
In-Reply-To: <YflGkNwyI6LUSVVk@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
         <Yfk6vEuZFtgtA+G+@kroah.com>
         <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
         <YflGkNwyI6LUSVVk@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: leA7HPKo2e59KhfKu2eGeqoLY4mV-OCA
X-Proofpoint-ORIG-GUID: jz9EWbU0-KhkJDOZM4bKd9foUK75RIZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_07,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 adultscore=0 impostorscore=0 mlxlogscore=926 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010085
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2022-02-01 at 15:41 +0100, Greg KH wrote:
> On Tue, Feb 01, 2022 at 09:24:50AM -0500, James Bottomley wrote:
> > [cc's added]
> > On Tue, 2022-02-01 at 14:50 +0100, Greg KH wrote:
[...]
> > > You all need to work together to come up with a unified place for
> > > this and stop making it platform-specific.
> > 
> > I'm not entirely sure of that.  If you look at the differences
> > between EFI variables and the COCO proposal: the former has an
> > update API which, in the case of signed variables, is rather
> > complex and a UC16 content requirement.  The latter is binary data
> > with read only/delete.  Plus each variable in EFI is described by a
> > GUID, so having a directory of random guids, some of which behave
> > like COCO secrets and some of which are EFI variables is going to
> > be incredibly confusing (and also break all our current listing
> > tools which seems somewhat undesirable).
> > 
> > So we could end up with 
> > 
> > <common path prefix>/efivar
> > <common path prefix>/coco
> 
> The powerpc stuff is not efi.  But yes, that is messy here.  But why
> doesn't the powerpc follow the coco standard?

There is no coco standard for EFI variables.  There's only a UEFI
variable standard which, I believe, power tries to follow in some
measure since the variables are mostly used for its version of secure
boot.  Certainly you're either a power or UEFI platform but not both,
so they could live at the same location ... that's not true with the
coco ones.  I added the cc's to see if there are other ideas, but I
really think the use cases are too disjoint.

As Daniel has previously proposed, it might be possible to unify the
power and UEFI implementations ... useful if we want them to respond to
the same tooling, but we'll do that by giving them the same EFI
semantics.  The semantics and source of the coco secrets will still be
immutable and completely alien to whatever backend does the non
volatile power/efi authenticated variables, so we'll still need two
different backends and then it's just a question of arguing about path,
which doesn't make sense as a blocker.

> > To achieve the separation, but I really don't see what this buys
> > us.  Both filesystems would likely end up with different backends
> > because of the semantic differences and we can easily start now in
> > different places (effectively we've already done this for efi
> > variables) and unify later if that is the chosen direction, so it
> > doesn't look like a blocker.
> > 
> > > Until then, we can't take this.
> > 
> > I don't believe anyone was asking you to take it.
> 
> I was on the review list...

You raised a doc/API concenrn.  I think you were on the review list to
ensure it got addressed.

James



