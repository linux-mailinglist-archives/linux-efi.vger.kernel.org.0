Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02EC4A6634
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 21:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbiBAUlu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 15:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbiBAUll (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 15:41:41 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347AC06139D
        for <linux-efi@vger.kernel.org>; Tue,  1 Feb 2022 12:39:41 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t9so25798319lji.12
        for <linux-efi@vger.kernel.org>; Tue, 01 Feb 2022 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCHRlnNYeF95Z0E47QMIOcWFuVuKdPbhrfyvVDY/gqE=;
        b=MXDhzlA/b4G0ig7K6rclUU3oFoycV4wfrA/3QQrZCzuP+ttoHw4Bxm4G81iw1INDFN
         r7R2Kcga3uKko9XYj8F7TDykqLDIgMiSLy25AeE7UFgHfozMn8YLGuIaxYD0pCjDiQNb
         hWYMvvj15zyQnU5NcJZipSrluZeUR82fdDnZ7f6TV3eRq1XG1vGwIec59TGu+zDsQ/0C
         CgtsZC5Derge+uNFYv0nHex+jsnb3KLMo6BNaf16VRHehk68wbW1JL8pZ3DzVJWSf4xI
         k5whar2GAfdItMDRQZfNjsClnweO6EXT7aAe2oZrHe2Suspg6kt+SogsQ825Ps6iSRWx
         zEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCHRlnNYeF95Z0E47QMIOcWFuVuKdPbhrfyvVDY/gqE=;
        b=dlNH/K9qDFOkf4Q6wlE6I9CqRqpnu9rDHkBgYd9r93oS0Bfhgp/3p6U0VgqpDCPWAS
         CMyjde3hvvQbPtZqNEA2GDyvnUZBz4YZqBUSJQB+1/mxe2bQc0J088gd+bwnanq7uQLm
         jsF8TT8XzklZS2XpBT/SW7AlPirvfRF1jWttHddTn36EeyAzepz4YxIaqJTOAyOXX8Mh
         impouuQTobb0U80ZsCepIMm1KDOeAHjYr3p5noTDGC+BIZDj4d6mV77oFdJY/rqQY3vv
         Cdmugj0xY7Pm+SEsNvstcfDIe2GENfcmMjtXBdglcIIZI9RWrjAFqEL+8AaUXJQpUUjG
         TQlw==
X-Gm-Message-State: AOAM531TQaJbVz7NWNv7mXkrEyWqPaRnNeWRlBsPq1wrsMybFO0Y4vSD
        X2nexfk/PUuXzYBSu/TXmEulrz79UsUay50Yj0NzJw==
X-Google-Smtp-Source: ABdhPJz3tdzw9oSrD2hKDXB+1mXZIyEnyffVNF8qPwJHccVAns3fQrSH2hPsPAIgwyf+fex4mAbmF0sJBtpDyR1gxY8=
X-Received: by 2002:a2e:a4a9:: with SMTP id g9mr17830908ljm.369.1643747979115;
 Tue, 01 Feb 2022 12:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128171804.569796-1-brijesh.singh@amd.com> <20220128171804.569796-43-brijesh.singh@amd.com>
In-Reply-To: <20220128171804.569796-43-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 1 Feb 2022 13:39:27 -0700
Message-ID: <CAMkAt6p-kEJXJxHcqay+eoMnTDCGj7tZXVDYwrovB3VkXCbYRg@mail.gmail.com>
Subject: Re: [PATCH v9 42/43] virt: sevguest: Add support to derive key
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
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
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 28, 2022 at 10:19 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> The SNP_GET_DERIVED_KEY ioctl interface can be used by the SNP guest to
> ask the firmware to provide a key derived from a root key. The derived
> key may be used by the guest for any purposes it chooses, such as a
> sealing key or communicating with the external entities.
>
> See SEV-SNP firmware spec for more information.
>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Peter Gonda <pgonda@google.com>

> ---
>  Documentation/virt/coco/sevguest.rst  | 17 ++++++++++
>  drivers/virt/coco/sevguest/sevguest.c | 45 +++++++++++++++++++++++++++
>  include/uapi/linux/sev-guest.h        | 17 ++++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
> index 47ef3b0821d5..aafc9bce9aef 100644
> --- a/Documentation/virt/coco/sevguest.rst
> +++ b/Documentation/virt/coco/sevguest.rst
> @@ -72,6 +72,23 @@ On success, the snp_report_resp.data will contains the report. The report
>  contain the format described in the SEV-SNP specification. See the SEV-SNP
>  specification for further details.
>
> +2.2 SNP_GET_DERIVED_KEY
> +-----------------------
> +:Technology: sev-snp
> +:Type: guest ioctl
> +:Parameters (in): struct snp_derived_key_req
> +:Returns (out): struct snp_derived_key_resp on success, -negative on error
> +
> +The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.

derived from ...

> +The derived key can be used by the guest for any purpose, such as sealing keys
> +or communicating with external entities.

Question: How would this be used to communicate with external
entities? Reading Section 7.2 it seems like we could pick the VCEK and
have no guest specific inputs and we'd get the same derived key as we
would on another guest on the same platform with, is that correct?

> +
> +The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
> +SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
> +on the various fields passed in the key derivation request.
> +
> +On success, the snp_derived_key_resp.data contains the derived key value. See
> +the SEV-SNP specification for further details.
>
>  Reference
>  ---------
> diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
> index 6dc0785ddd4b..4369e55df9a6 100644
> --- a/drivers/virt/coco/sevguest/sevguest.c
> +++ b/drivers/virt/coco/sevguest/sevguest.c
> @@ -392,6 +392,48 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>         return rc;
>  }
>
> +static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
> +{
> +       struct snp_guest_crypto *crypto = snp_dev->crypto;
> +       struct snp_derived_key_resp resp = {0};
> +       struct snp_derived_key_req req = {0};
> +       int rc, resp_len;
> +       u8 buf[64+16]; /* Response data is 64 bytes and max authsize for GCM is 16 bytes */
> +
> +       if (!arg->req_data || !arg->resp_data)
> +               return -EINVAL;
> +
> +       /* Copy the request payload from userspace */
> +       if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
> +               return -EFAULT;
> +
> +       /*
> +        * The intermediate response buffer is used while decrypting the
> +        * response payload. Make sure that it has enough space to cover the
> +        * authtag.
> +        */
> +       resp_len = sizeof(resp.data) + crypto->a_len;
> +       if (sizeof(buf) < resp_len)
> +               return -ENOMEM;
> +
> +       /* Issue the command to get the attestation report */
> +       rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> +                                 SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> +                                 &arg->fw_err);
> +       if (rc)
> +               goto e_free;
> +
> +       /* Copy the response payload to userspace */
> +       memcpy(resp.data, buf, sizeof(resp.data));
> +       if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
> +               rc = -EFAULT;
> +
> +e_free:
> +       memzero_explicit(buf, sizeof(buf));
> +       memzero_explicit(&resp, sizeof(resp));
> +       return rc;
> +}
> +
>  static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
>  {
>         struct snp_guest_dev *snp_dev = to_snp_dev(file);
> @@ -421,6 +463,9 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>         case SNP_GET_REPORT:
>                 ret = get_report(snp_dev, &input);
>                 break;
> +       case SNP_GET_DERIVED_KEY:
> +               ret = get_derived_key(snp_dev, &input);
> +               break;
>         default:
>                 break;
>         }
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 081d314a6279..bcd00a6d4501 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -30,6 +30,20 @@ struct snp_report_resp {
>         __u8 data[4000];
>  };
>
> +struct snp_derived_key_req {
> +       __u32 root_key_select;
> +       __u32 rsvd;
> +       __u64 guest_field_select;
> +       __u32 vmpl;
> +       __u32 guest_svn;
> +       __u64 tcb_version;
> +};
> +
> +struct snp_derived_key_resp {
> +       /* response data, see SEV-SNP spec for the format */
> +       __u8 data[64];
> +};
> +
>  struct snp_guest_request_ioctl {
>         /* message version number (must be non-zero) */
>         __u8 msg_version;
> @@ -47,4 +61,7 @@ struct snp_guest_request_ioctl {
>  /* Get SNP attestation report */
>  #define SNP_GET_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x0, struct snp_guest_request_ioctl)
>
> +/* Get a derived key from the root */
> +#define SNP_GET_DERIVED_KEY _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x1, struct snp_guest_request_ioctl)
> +
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> --
> 2.25.1
>
