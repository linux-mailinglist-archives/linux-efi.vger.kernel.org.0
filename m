Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44383FF12D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 18:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhIBQVf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 12:21:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346029AbhIBQVf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 12:21:35 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182G3LbH129623;
        Thu, 2 Sep 2021 12:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=87Sy2UVic7iNWomN6tkxoII7Iud6lqmX5CIzHTtPV1M=;
 b=bwi7370a+2vBMD2fXIDivxj1Fue7ECluu6vYl2mlYVczNdyEic6gteclCEeqOYSHObck
 PBsOpUQh98tuQFc1hKZEo7uuQ5b9TjW2NJpmnOQ7+ZluxmwcBhuTVOSU6DMZPv+ABjGD
 a0ibntlvPHLxAN9tQV8PPfzj0lnXElVCw9Hpprw+AEr0E0HDrEZd1mUy5UXxiOQpiibT
 f0BXPNsSrdxQfxnw5dJklbd8103l/YLUOmkv96Tkz3+9AHm4SwFxUWW955wJqVW/Xci7
 XFsWJbDntLeTNrT+M1xblo0aBmNfRCo5cbvfyh0zlc9ub3Wt0BfvFcNbicyiRRCy9jPy tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3au1rd8mua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 12:19:19 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 182G3QOW130004;
        Thu, 2 Sep 2021 12:19:18 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3au1rd8mu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 12:19:18 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 182GHpww014478;
        Thu, 2 Sep 2021 16:19:17 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3atdxufq6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 16:19:17 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 182GJGQe31588832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 16:19:16 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67A4578060;
        Thu,  2 Sep 2021 16:19:16 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B016A7805F;
        Thu,  2 Sep 2021 16:19:14 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.89.117])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Sep 2021 16:19:14 +0000 (GMT)
Message-ID: <61212d923295203173b1a8c3c24b6dd19835c57e.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] Allow access to confidential computing secret area
 in SEV guests
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
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Sep 2021 09:19:13 -0700
In-Reply-To: <YTD3U70FCkXzNMrF@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
         <YTDKUe8rXrr0Zika@kroah.com>
         <e6fb1d54605690cc1877d7140fc9346c22268111.camel@linux.ibm.com>
         <YTDoS5XycY3gO4MM@kroah.com>
         <6cb65cb3bd69ae69bde044f809525e478bdb8512.camel@linux.ibm.com>
         <YTD3U70FCkXzNMrF@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cvudAN3sqTWqQyDJ5vQ4TqceYxK7OTYF
X-Proofpoint-ORIG-GUID: vnF0_qy6a1Qk9vcAQreBukm9fxIBZXDE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2021-09-02 at 18:09 +0200, Greg KH wrote:
> On Thu, Sep 02, 2021 at 08:19:51AM -0700, James Bottomley wrote:
> > On Thu, 2021-09-02 at 17:05 +0200, Greg KH wrote:
> > > On Thu, Sep 02, 2021 at 07:35:10AM -0700, James Bottomley wrote:
> > > > On Thu, 2021-09-02 at 14:57 +0200, Greg KH wrote:
> > > > [...]
> > > > > Wait, why are you using securityfs for this?
> > > > > 
> > > > > securityfs is for LSMs to use. 
> > > > 
> > > > No it isn't ... at least not exclusively; we use it for non LSM
> > > > security purposes as well, like for the TPM BIOS log and for
> > > > IMA.  What makes you think we should start restricting
> > > > securityfs to LSMs only?  That's not been the policy up to now.
> > > 
> > > Well that was the original intent of the filesystem when it was
> > > created, but I guess it's really up to the LSM maintainers now
> > > what they want it for.
> > > 
> > > > >  If you want your own filesystem to play around with stuff
> > > > > like this, great, write your own, it's only 200 lines or less
> > > > > these days.  We used to do it all the time until people
> > > > > realized they should just use sysfs for driver stuff.
> > > > 
> > > > This is a security purpose (injected key retrieval), so
> > > > securityfs seems to be the best choice.  It's certainly
> > > > possible to create a new filesystem, but I really think things
> > > > with a security purpose should use securityfs so people know
> > > > where to look for them.
> > > 
> > > knowing where to look should not be an issue, as that should be
> > > documented in Documentation/ABI/ anyway, right?
> > > 
> > > It's just the overlap / overreach of using an existing filesystem
> > > for things that don't seem to be LSM-related that feels odd to
> > > me.
> > > 
> > > Why not just make a cocofs if those people want a filesystem
> > > interface?
> > > It's 200 lines or so these days, if not less, and that way you
> > > only mount what you actually need for the system.
> > 
> > Secrets transfer is actually broader than confidential computing,
> > although confidential computing is a first proposed use, so I think
> > cocofs would be too narrow.
> > 
> > > Why force this into securityfs if it doesn't have to be?
> > 
> > It's not being forced.  Secrets transfer is a security function in
> > the same way the bios log is.
> 
> Is the bios log in securityfs today?

Yes. It's under /sys/kernel/security/tpm0/  All the ima policy control
and its log is under /sys/kernel/security/ima/  that's why I think
declaring securityfs as being for anything security related is already
our de facto (if not de jure) policy.

> Anyway, it's up to the securityfs maintainer (i.e. not me), but
> personally, I think this should be a separate filesystem as that
> would probably make things easier in the long run...

I know Al likes this business of loads of separate filesystems, but
personally I'm not in favour.  For every one you do, you not only have
to document it all, you also have to find a preferred mount point that
the distributions can agree on and also have them agree to enable the
mount for, which often takes months of negotiation.  Having fewer
filesystems grouped by common purpose which have agreed mount points
that distros actually mount seems a far easier approach to enablement.

James


