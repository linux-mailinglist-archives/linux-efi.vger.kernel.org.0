Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36567464F03
	for <lists+linux-efi@lfdr.de>; Wed,  1 Dec 2021 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349628AbhLANvZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Dec 2021 08:51:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9180 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349647AbhLANvK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Dec 2021 08:51:10 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DcDDM019892;
        Wed, 1 Dec 2021 13:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kLrwl+sjdutKijzkkRE3ijtdTFL3tqrSpl9/QVu7zds=;
 b=dg4EXzmMpz7zee6v+kPfKEj4zvO4Ui3JsGX2AaIlIuxZ6bw2HUlpOktbMEZYq5rX+7ly
 d8Pg9yE9zet+zMbknV+j4qNfp7DKruwgMmJWRQMUIn8m2Js32Yfiq1gbzVJOc4D8He8Q
 x5LAJWwjNbvkunnyjhmu00GA2R2SZu29EgSHMGqGoaEipAeX8XqEweeGtcWR9ADiFGam
 VRVm0VQ80ldo/mtOK8MVDtOv5/WZjt/dZO4VdOR3WpFfmpZktMCRddmCqrMXbnsvrcJj
 To7Akl58jpyeNCU1Xupkcqg5ZNM2kbImDziP1SvTFqfj+TOyPF+9GT9l1sYy+pc8wkNK 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cp9bshbhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 13:47:03 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1DcDj9020017;
        Wed, 1 Dec 2021 13:47:02 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cp9bshbgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 13:47:02 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DTFWN020620;
        Wed, 1 Dec 2021 13:47:00 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3ckca9rdrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 13:47:00 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1DkvHR21954996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 13:46:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFB27AE04D;
        Wed,  1 Dec 2021 13:46:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76185AE055;
        Wed,  1 Dec 2021 13:46:54 +0000 (GMT)
Received: from sig-9-65-78-183.ibm.com (unknown [9.65.78.183])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 13:46:54 +0000 (GMT)
Message-ID: <61f5d74f861ce1015831649d3bca9272a2e3b7bf.camel@linux.ibm.com>
Subject: Re: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
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
Date:   Wed, 01 Dec 2021 08:46:53 -0500
In-Reply-To: <YadOLrHb14MEfphi@iki.fi>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
         <20211124044124.998170-10-eric.snowberg@oracle.com>
         <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
         <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com> <YadOLrHb14MEfphi@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m7A-PkvjVAc_VwmPRrA3SGHBXpos4Gvu
X-Proofpoint-GUID: CoTpQMEuZT4FveB5sK-lbS6R6yGDSE-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010078
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2021-12-01 at 12:27 +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 30, 2021 at 05:21:45PM +0000, Eric Snowberg wrote:
> > 
> > 
> > > On Nov 26, 2021, at 5:49 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > 
> > > On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> > >> In preparation for returning either the existing
> > >> restrict_link_by_builtin_and_secondary_trusted or the upcoming
> > >> restriction that includes the trusted builtin, secondary and
> > >> machine keys, to improve clarity, rename
> > >> get_builtin_and_secondary_restriction to get_secondary_restriction.
> > >> 
> > >> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > >> ---
> > >> v6: Initial version
> > >> v7: Unmodified from v7
> > >> v8: Code unmodified from v7, added Mimi's Reviewed-by
> > >> ---
> > >>  certs/system_keyring.c | 4 ++--
> > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >> 
> > >> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > >> index 692365dee2bd..8f1f87579819 100644
> > >> --- a/certs/system_keyring.c
> > >> +++ b/certs/system_keyring.c
> > >> @@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
> > >>   * Allocate a struct key_restriction for the "builtin and secondary trust"
> > >>   * keyring. Only for use in system_trusted_keyring_init().
> > >>   */
> > >> -static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
> > >> +static __init struct key_restriction *get_secondary_restriction(void)
> > >>  {
> > >>         struct key_restriction *restriction;
> > >>  
> > >> @@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
> > >>                                KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
> > >>                                KEY_USR_WRITE),
> > >>                               KEY_ALLOC_NOT_IN_QUOTA,
> > >> -                             get_builtin_and_secondary_restriction(),
> > >> +                             get_secondary_restriction(),
> > >>                               NULL);
> > >>         if (IS_ERR(secondary_trusted_keys))
> > >>                 panic("Can't allocate secondary trusted keyring\n");
> > > 
> > > This is wrong order.
> > > 
> > > You should first do the changes that make the old name
> > > obsolete and only after that have a patch that does the
> > > rename. Unfortunately, this patch cannot possibly acked
> > > with the current order.
> >
> > I can change the order, but I'm confused how this would work for a git bisect. 
> > If the rename happens afterwards, now two patches will always need to be 
> > reverted instead of the possibility of one.  Is this your expectation?

If the keyring name change is independent of any other changes, as
Jarkko suggested, nothing would break.

> I'd drop this patch altogether. Old name is a bit ugly but does it matter
> all that much?

The name "get_builtin_and_secondary_restriction" implies trust based on
keys in the ".builtin_trusted_keys" and ".secondary_trusted_keys"
keyrings.  This patch set is extending that to include keys on the new
".machine" keyring, by linking it to the secondary keyring.  Is leaving
the name unchanged really an option?

> 
> You already 16 patches without this.

Agreed, it's a lot.  In the past, I've asked Eric to see if some of
them could be squashed.

Mimi

