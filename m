Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF44A5E2D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiBAOZ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 09:25:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239240AbiBAOZ2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 09:25:28 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211E3fIh002076;
        Tue, 1 Feb 2022 14:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=mreXuaP/jhEfQGa2pduCiURq5d9Q94KDVgGiwjc7zzo=;
 b=hAx6jmKcHJLBSUJ/gkK2q1brIyFMRnzYEFT8qfF+qLkoeJJAvn6Avt6HV+iNYuWvaxcu
 t4tZAzm1jb8/bqL3atjoWlvEsHyRJURGAM8w+/G8Tnij7giOKrARO0gkwnwz9i2qPxcn
 aZ/LeRxQUhmh784fC5jIHiDyjodEaRkPaGgwiR+kf+fQLoeieQuPl/K4HBhxkdcq1prP
 Lv5Dw/IWGsxRLp/I7FIBGWflGepYIbovnsYyHBvEGfep0pFd3YOLW7D3HTSdFy1AT+cS
 w25u0bEI9cBZ5sE/V15iNA1VcW/TtBCjmIoKH6nqufJYBkFfTfXuzTDbfOYVCdGVglIC kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxn4hvgky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 14:25:02 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211Dx1ur021079;
        Tue, 1 Feb 2022 14:25:02 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxn4hvgk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 14:25:02 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211EIajb010966;
        Tue, 1 Feb 2022 14:25:00 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3dvw7bdw8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 14:25:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211EOuNg34734354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 14:24:56 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6457808E;
        Tue,  1 Feb 2022 14:24:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3391780A0;
        Tue,  1 Feb 2022 14:24:51 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.75.243])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 14:24:51 +0000 (GMT)
Message-ID: <37779659ca96ac9c1f11bcc0ac0665895c795b54.camel@linux.ibm.com>
Subject: Re: [PATCH v7 0/5] Allow guest access to EFI confidential computing
 secret area
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
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
        gjoyce@ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mjg59@srcf.ucam.org, mpe@ellerman.id.au, dja@axtens.net
Date:   Tue, 01 Feb 2022 09:24:50 -0500
In-Reply-To: <Yfk6vEuZFtgtA+G+@kroah.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
         <Yfk6vEuZFtgtA+G+@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KKTyI9pQI8Y36SJdNW1gn8e_DMUDwLR-
X-Proofpoint-ORIG-GUID: S9dqeW5zLuNZ9BvqjN1WezAHnW6K66xY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_06,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 mlxlogscore=850 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010078
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[cc's added]
On Tue, 2022-02-01 at 14:50 +0100, Greg KH wrote:
> On Tue, Feb 01, 2022 at 12:44:08PM +0000, Dov Murik wrote:
[...]
> > # ls -la /sys/kernel/security/coco/efi_secret
> > total 0
> > drwxr-xr-x 2 root root 0 Jun 28 11:55 .
> > drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
> > -r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-
> > 06879ce3da0b
> > -r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-
> > d3a0b54312c6
> > -r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-
> > ff17f78864d2
> 
> Please see my comments on the powerpc version of this type of thing:
> 	
> https://lore.kernel.org/r/20220122005637.28199-1-nayna@linux.ibm.com

If you want a debate, actually cc'ing the people on the other thread
would have been a good start ...

For those added, this patch series is at:

https://lore.kernel.org/all/20220201124413.1093099-1-dovmurik@linux.ibm.com/

> You all need to work together to come up with a unified place for
> this and stop making it platform-specific.

I'm not entirely sure of that.  If you look at the differences between
EFI variables and the COCO proposal: the former has an update API
which, in the case of signed variables, is rather complex and a UC16
content requirement.  The latter is binary data with read only/delete. 
Plus each variable in EFI is described by a GUID, so having a directory
of random guids, some of which behave like COCO secrets and some of
which are EFI variables is going to be incredibly confusing (and also
break all our current listing tools which seems somewhat undesirable).

So we could end up with 

<common path prefix>/efivar
<common path prefix>/coco

To achieve the separation, but I really don't see what this buys us. 
Both filesystems would likely end up with different backends because of
the semantic differences and we can easily start now in different
places (effectively we've already done this for efi variables) and
unify later if that is the chosen direction, so it doesn't look like a
blocker.

> Until then, we can't take this.

I don't believe anyone was asking you to take it.

James


