Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE7476243
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhLOTzk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 14:55:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231906AbhLOTzi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 14:55:38 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFJkP7x016328;
        Wed, 15 Dec 2021 19:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xnvALnzuykUtUWsTbESF0a7fLCarrfbygXfJoV4B4s8=;
 b=azKX6PGpEpCo9QxRZgrFd6J3f3CJxXrGv8Ftx+/BSWmy9gfRpqjQkerRlmQsVxn4wrRm
 3iHlAGD1zZmVLbL5vEdi/pK64iA6RqBLn85Gjy+4rkIcqapeUaYPdhQbUY2jjY/kO7qu
 wasQ/s1T9mAg0gDZWZtv0xfJwH7TtJhcfRwWfx8Key8XDQFd9j7K+BUXWKneLrV/S76V
 lt5qpXloSXE3n9p7Ag40uRFaXdqRtoHnFhDvNfm4g8xFk1eFJIsaL0/GA5vSZLzlIk0W
 NWW4Sl8uGUQNjK9AMntGk1ZvAsyG6ZLHnL64T6tGOZNYAAWh34t6lrtlpyOEnJfj0shi jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cypt784df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 19:55:03 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BFJqrxZ028567;
        Wed, 15 Dec 2021 19:55:03 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cypt784bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 19:55:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BFJqpHX002120;
        Wed, 15 Dec 2021 19:55:00 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3cy78e8tap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 19:55:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BFJkwOQ49021430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 19:46:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D65F34C040;
        Wed, 15 Dec 2021 19:54:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08D674C044;
        Wed, 15 Dec 2021 19:54:55 +0000 (GMT)
Received: from sig-9-65-74-182.ibm.com (unknown [9.65.74.182])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Dec 2021 19:54:54 +0000 (GMT)
Message-ID: <55d8186018eaf979592349dc7fefd886e10d4c19.camel@linux.ibm.com>
Subject: Re: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Date:   Wed, 15 Dec 2021 14:54:54 -0500
In-Reply-To: <31FE813A-91D5-46B8-9658-21F3F1418643@oracle.com>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-10-eric.snowberg@oracle.com>
         <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
         <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com> <YadOLrHb14MEfphi@iki.fi>
         <61f5d74f861ce1015831649d3bca9272a2e3b7bf.camel@linux.ibm.com>
         <31FE813A-91D5-46B8-9658-21F3F1418643@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vbRrD6GbhpAi0WTQ9sI-A4Is6MJKymqp
X-Proofpoint-GUID: u9yowdspx9vXKqSEf6uZvdbN8FscDNiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_12,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150108
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2021-12-15 at 18:14 +0000, Eric Snowberg wrote:
> 
> > On Dec 1, 2021, at 6:46 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Wed, 2021-12-01 at 12:27 +0200, Jarkko Sakkinen wrote:
> >> On Tue, Nov 30, 2021 at 05:21:45PM +0000, Eric Snowberg wrote:
> >>> 
> >>> 
> >>>> On Nov 26, 2021, at 5:49 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >>>> 
> >>>> On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> >>>>> In preparation for returning either the existing
> >>>>> restrict_link_by_builtin_and_secondary_trusted or the upcoming
> >>>>> restriction that includes the trusted builtin, secondary and
> >>>>> machine keys, to improve clarity, rename
> >>>>> get_builtin_and_secondary_restriction to get_secondary_restriction.
> >>>>> 
> >>>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> >>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>>>> ---
> >>>>> v6: Initial version
> >>>>> v7: Unmodified from v7
> >>>>> v8: Code unmodified from v7, added Mimi's Reviewed-by
> >>>>> ---
> >>>>> certs/system_keyring.c | 4 ++--
> >>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>> 
> >>>>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> >>>>> index 692365dee2bd..8f1f87579819 100644
> >>>>> --- a/certs/system_keyring.c
> >>>>> +++ b/certs/system_keyring.c
> >>>>> @@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
> >>>>>  * Allocate a struct key_restriction for the "builtin and secondary trust"
> >>>>>  * keyring. Only for use in system_trusted_keyring_init().
> >>>>>  */
> >>>>> -static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
> >>>>> +static __init struct key_restriction *get_secondary_restriction(void)
> >>>>> {
> >>>>>        struct key_restriction *restriction;
> >>>>> 
> >>>>> @@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
> >>>>>                               KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
> >>>>>                               KEY_USR_WRITE),
> >>>>>                              KEY_ALLOC_NOT_IN_QUOTA,
> >>>>> -                             get_builtin_and_secondary_restriction(),
> >>>>> +                             get_secondary_restriction(),
> >>>>>                              NULL);
> >>>>>        if (IS_ERR(secondary_trusted_keys))
> >>>>>                panic("Can't allocate secondary trusted keyring\n");
> >>>> 
> >>>> This is wrong order.
> >>>> 
> >>>> You should first do the changes that make the old name
> >>>> obsolete and only after that have a patch that does the
> >>>> rename. Unfortunately, this patch cannot possibly acked
> >>>> with the current order.
> >>> 
> >>> I can change the order, but I'm confused how this would work for a git bisect. 
> >>> If the rename happens afterwards, now two patches will always need to be 
> >>> reverted instead of the possibility of one.  Is this your expectation?
> > 
> > If the keyring name change is independent of any other changes, as
> > Jarkko suggested, nothing would break.
> > 
> >> I'd drop this patch altogether. Old name is a bit ugly but does it matter
> >> all that much?
> > 
> > The name "get_builtin_and_secondary_restriction" implies trust based on
> > keys in the ".builtin_trusted_keys" and ".secondary_trusted_keys"
> > keyrings.  This patch set is extending that to include keys on the new
> > ".machine" keyring, by linking it to the secondary keyring.  Is leaving
> > the name unchanged really an option?
> > 
> >> 
> >> You already 16 patches without this.
> > 
> > Agreed, it's a lot.  In the past, I've asked Eric to see if some of
> > them could be squashed.
> 
> The series grew based on requests added in each round.  How about
> I drop IMA support from the next round?  This would eliminate nine patches
> from the series (5, 6, 7, 9-14), leaving six patches to introduce and enable 
> the new machine keyring (3, 4, 8, 15-17).  The first two patches could 
> be taken today.  The only reason the first two are included is to get this series 
> through the kernel test robot.
> 
> This would allow the machine keyring to be used for module signing.  Afterwards 
> I could introduce the CA restriction behind another Kconfig in a different series to 
> add back IMA support. Let me know if this would be a better approach.

Once you allow ALL the MOK keys to be loaded onto the .machine keyring,
limiting which keys should be loaded will change the existing expected
behavior.  So you indeed would need to define a new config option.

Your patch set links the ".machine" keyring to the
".secondary_trusted_keys" kerying. Based on
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY config being
enabled, determines whether IMA trusts the secondary keyring.

From IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY:
        help
          Keys may be added to the IMA or IMA blacklist keyrings, if
the
          key is validly signed by a CA cert in the system built-in or
          secondary trusted keyrings.

          Intermediate keys between those the kernel has compiled in
and the
          IMA keys to be added may be added to the system secondary
keyring,
          provided they are validly signed by a key already resident in
the
          built-in or secondary trusted keyrings.

A dependency to prevent enabling this configuration, if the ".machine"
keyring is enabled, would need to be defined.

thanks,

Mimi

