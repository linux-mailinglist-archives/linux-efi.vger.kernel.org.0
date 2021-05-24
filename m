Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D068F38F213
	for <lists+linux-efi@lfdr.de>; Mon, 24 May 2021 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhEXROf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 May 2021 13:14:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232543AbhEXROe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 May 2021 13:14:34 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14OH797B065278;
        Mon, 24 May 2021 13:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=4ZmEwV0uh3M98yAId9fHizrj3Aea8obXVruHYcQPyoY=;
 b=p/ddU/0OjkByyZA+WlUU9jgJibTNWOk/ersEIpahCPK/KUVJC0CIkarV5dt9ipJ+j6rB
 xcSJek52XGjC9bNDYpqKDnNP92D6bp5HffbfGPtzn7Nl9h4lPRyqyHuFHUIYsBHh8kOx
 eklaUx5/pEPv/D13KX032OfEAE+JYKnKPZuOF0zi3coa7qzfQMsVYcGvZ53o0M8hNHt5
 4lX3a0MiBp1dxWpOonWzsD96nwRUDLx587qHp+YL0GhOihnMFM9l0y8mGusynKjZuO1L
 mPfS0rS4hl106pSKbOcVKc7HV/CrY5Mt88nlM17INJ2oRkHOiDcihcLNdT+dNjRUfY9S QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38repqk3vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 13:12:59 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14OH7pXJ067740;
        Mon, 24 May 2021 13:12:58 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38repqk3v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 13:12:58 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14OH1VVH014287;
        Mon, 24 May 2021 17:12:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 38psk98nj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 May 2021 17:12:57 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14OHCtCs17236392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 17:12:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C3E57805F;
        Mon, 24 May 2021 17:12:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F85E7805C;
        Mon, 24 May 2021 17:12:51 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.208.94])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 May 2021 17:12:51 +0000 (GMT)
Message-ID: <ddfbcb36b928f6b0a1e9b3262b55cce48a3c326c.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dov Murik <dovmurik@linux.ibm.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Mon, 24 May 2021 10:12:50 -0700
In-Reply-To: <81aa5e70-ab94-393c-92e1-fdac14708aff@linux.intel.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
         <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
         <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
         <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
         <45842efd-7b6b-496f-d161-e5786760078d@linux.intel.com>
         <YKuXI9TUBa3sjY3e@work-vm>
         <81aa5e70-ab94-393c-92e1-fdac14708aff@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lWgl0aqf5oYcyJPwq_WrchYyFsdxy44Y
X-Proofpoint-GUID: MxNFfOe-f3OurKcVXDFhUhKX7JWlYjYL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240099
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-05-24 at 09:31 -0700, Andi Kleen wrote:
> On 5/24/2021 5:08 AM, Dr. David Alan Gilbert wrote:
> > * Andi K
> > Is there any way we could merge these two so that the TDX/SVKL
> > would look similar to SEV/ES to userspace?  If we needed some
> > initrd glue here for luks it would be great if we could have one
> > piece of glue. [I'm not sure if the numbering/naming of the
> > secrets, and their format are defined in the same way]
> Maybe. There might well be differences in the contents as you say.
> So far SVKL doesn't really exist yet,  initially there will be the
> initrd based agents. The agents definitely will need to know about
> TDX.
> > Do you think the ioctl is preferable to read+ftruncate/unlink ?
> > And if it was an ioctl, again could we get some standardisation
> > here - i.e. maybe a /dev/confguest with a CONF_COMP_GET_KEY etc ?
> 
> The advantage of the two ioctls is that they are very simple.
> Anything with a file system would be a lot more complicated. For
> security related code simplicity is a virtue.

This RFC contained the FS code.  In size terms its very comparable to
your ioctl.

> Also since it's a really simple read and clear model I don't expect
> the value to be used widely, since it will be gone after boot
> anyways.

Enumeration looks to be problematic with your interface ... what are
you supposed to do, keep calling ACPI_SVKL_GET_KEY_INFO on an advancing
index until it gives you an error and then try to work out what key
you're interested in by one of its numeric properties?

I think a GUIDed structure actually helps here because we don't have to
have someone assign, say, u16 types to keys we're interested in and the
filesystem does all the enumeration for us.  It also means new use
cases can simply expand the properties without waiting for any
internals to catch up.

James


